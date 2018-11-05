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

class ContentTypesController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication

  before_action :set_content_type, only: [:show]
  before_action :set_content_type_edit, only: [:edit, :update, :destroy]

  def new
    @content_type = current_user.content_types.build
  end

  def edit
  end

  def destroy
    if(params.key? :activate)
      @content_type.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @content_type.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @content_type.save
      redirect_to content_types_url, notice: message
    else
      render :edit
    end
  end

  def create

    @content_type = current_user.content_types.build(content_type_params)

    if @content_type.save
      redirect_to @content_type, notice: t('flash.notice.save_success')
    else
      render :new
    end
  end

  def show
  #  @content_type = ContentType.find params[:id]
  end

  def update

    if @content_type.update(content_type_params)
      redirect_to @content_type, notice: t('flash.notice.save_success')
    else
      render :edit
    end
  end

  def index


    @content_type={"description"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @content_type=content_type_params_index
      @content_type["page"]=params[:page]
      session[:content_type]=@content_type
    else
        if session.has_key? :content_type
          @content_type=session[:content_type]
          params[:page]=@content_type["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @content_type["inactive"]=="Y"
        @content_types = current_user.content_types
        .inactive
        .where([" description ilike ? ","%#{@content_type["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @content_types = current_user.content_types
        .active
        .where([" description ilike ? ","%#{@content_type["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end

    else
        @content_types = {}
    end

  end

  private

    def set_content_type_edit
      @content_type = current_user.content_types.find(params[:id])
    end

    def set_content_type
      #@content_type = ContentType.find(params[:id])
      @content_type = current_user.content_types.find(params[:id])
    end

    def content_type_params
      params.require(:content_type).permit(:description,:feature)
    end


    def content_type_params_index
      params.require(:content_type).permit(:description,:inactive)
    end
end
