# LifeProject - project management software of your life
# Copyright (C) 2018  Rosemberg de Oliveira
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class QuotationsController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication
  before_action :set_quotation, only: [:show]
  before_action :set_quotation_edit, only: [:edit, :update, :destroy]


  def addperson

   @size_people=params[:size_people];
   @quotation=QuotationPerson.new
   render partial: "quotation_person_fields_tag"

  end

  def new
    @quotation = current_user.quotations.build
    2.times do @quotation.quotation_people.build end
    @quotation.type_quote=:quote
  end

  def edit

    @quotation.content_description=@quotation.content.description if @quotation.content.present?

    @quotation.quotation_people.map do |cp|
      cp.person_name=cp.person.name
    end

  end

  def destroy
    if(params.key? :activate)
      @quotation.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @quotation.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @quotation.save
      redirect_to quotations_url, notice: message
    else
      render :edit
    end
  end

  def create
    @quotation = current_user.quotations.build(quotation_params)


    @quotation.quotation_people.map do |cp|
      cp.user_id=current_user.id
    end

    #if the user do not type the order and the quotation is from a content, we get the amount the quotation to
    #that content and then we set the next value as the order of the quotations saved
    if (@quotation.order.nil? && !@quotation.content_id.nil?)
       amount=current_user.quotations.active.where(content_id: @quotation.content_id).count
       @quotation.order=amount+1
    end


    if @quotation.save
      redirect_to @quotation, notice: t('flash.notice.save_success') #'Quotation was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def update

    #if the user do not type the order and the quotation is from a content, we get the amount the quotation to
    #that content and then we set the next value as the order of the quotations saved
    attributes = quotation_params.clone

    if (attributes[:order].empty? && !attributes[:content_id].nil?)
       amount=current_user.quotations.active.where(content_id: attributes[:content_id]).count
       attributes[:order]=amount+1
    end

    unless attributes[:quotation_people_attributes].nil? 
      attributes[:quotation_people_attributes].each do |key,cp|
        if (!cp[:person_id].empty? && cp[:id].nil?)
          cp[:user_id]=current_user.id
        end
      end
    end


    if @quotation.update(attributes)
      redirect_to @quotation, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    @quotation={"quotation"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @quotation=quotation_params_index
      @quotation["page"]=params[:page]
      session[:quotation]=@quotation
    else
        if session.has_key? :quotation
          @quotation=session[:quotation]
          params[:page]=@quotation["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @quotation["inactive"]=="Y"
        @quotations = current_user.quotations
        .inactive
        .where([" quotation ilike ? ","%#{@quotation["quotation"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @quotations = current_user.quotations
        .active
        .where([" quotation ilike ? ","%#{@quotation["quotation"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end


    else
        @quotations = {}
    end

  end

  private

    def set_quotation_edit
      @quotation = current_user.quotations.find(params[:id])
    end

    def set_quotation
      @quotation = current_user.quotations.find(params[:id])
    end

    def quotation_params
      params.require(:quotation).permit(:quotation,:content_id,:page_initial,:page_final,:order,:type_quote,:indication,
      quotation_people_attributes: [:id,:person_id, :type_person, :_destroy, :person_name])
    end

    def quotation_params_index
      params.require(:quotation).permit(:quotation,:inactive)
    end

end
