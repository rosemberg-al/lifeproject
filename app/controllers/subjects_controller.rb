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

class SubjectsController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication

  before_action :set_subject, only: [:show]
  before_action :set_subject_edit, only: [:edit, :update, :destroy]

  def json

   if params.has_key?(:description) && !params[:description].nil?
     description=params[:description]
     #@people=Person.active.select("id, name").where("name like '%#{name}%'").limit(30)

     @subjects=current_user.subjects.active.select("id, description as label").where("description ilike '%#{description}%'").limit(30)
     logger.debug "LISTA: #{@subjects.inspect}"
     #head :ok
     render :json => @subjects
   else
     head :ok
   end

  end

  def new
    @subject = current_user.subjects.build
    #@subject = Subject.new
    #puts @subject
  end

  def edit
  end

  def destroy
    if(params.key? :activate)
      @subject.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @subject.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @subject.save
      redirect_to subjects_url, notice: message
    else
      render :edit
    end
  end

  def create

    @subject = current_user.subjects.build(subject_params)
    #@subject = Subject.new(subject_params)
    #@subject.user_id = current_user.id
    if @subject.save
      redirect_to @subject, notice: t('flash.notice.save_success') #'Subject was successfully created.'
    else
      render :new
    end
  end

  def show
    #@subject = Subject.find params[:id]
  end

  def update

    if @subject.update(subject_params)
      redirect_to @subject, notice: t('flash.notice.save_success') #notice: 'Subject was successfully updated.'
    else
      render :edit
    end
  end

  def index

    @subject={"description"=>'',"inactive"=>'N'}

    if params.has_key? :q
      @subject=subject_params_index
      @subject["page"]=params[:page]
      session[:subject]=@subject
    else


        if session.has_key? :subject
          # logger.debug "@@@@: #{session[:subject].inspect}"
          # logger.debug "****: #{session[:subject]["description"]}"

          @subject=session[:subject]
          #params[:inactive]=@inactive
          #params[:description]=@description
          params[:page]=@subject["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @subject["inactive"]=="Y"
        @subjects = current_user.subjects
        .inactive
        .where([" description ilike ? ","%#{@subject["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @subjects = current_user.subjects
        .active
        .where([" description ilike ? ","%#{@subject["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end
        #@subjects = Subject.index(
        #  {:current_user=>current_user,
        #    :description=>@description,
        #    :inactive=>@inactive,
        #    :page=>params[:page],
        #    :per_page=>PER_PAGE}
        #)
        #@subjects = current_user.subjects.where([" description ilike ? ","%#{@description}%"])
        #.where(inactivated_at: nil)
        #.most_recent
        #.page(params[:page])
        #.per(PER_PAGE)

    else
        @subjects = {}
    end

  end

  private

    def set_subject_edit
      @subject = current_user.subjects.find(params[:id])
      #@subject = Subject.find(params[:id])
    end

    def set_subject
      #@subject = Subject.find(params[:id])
      @subject = current_user.subjects.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:description)
    end

    def subject_params_index
      params.require(:subject).permit(:description,:inactive)
    end
end
