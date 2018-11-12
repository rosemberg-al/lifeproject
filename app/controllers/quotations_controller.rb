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



  def new
    @quotation = current_user.quotations.build
  end

  def edit

  #  @quotation.content_description=@quotation.content.description

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
    if @quotation.save
      redirect_to @quotation, notice: t('flash.notice.save_success') #'Person was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def update

    if @quotation.update(quotation_params)
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
      params.require(:quotation).permit(:quotation,:content_id,:page_initial,:page_final,:order)
    end

    def quotation_params_index
      params.require(:quotation).permit(:quotation,:inactive)
    end

end
