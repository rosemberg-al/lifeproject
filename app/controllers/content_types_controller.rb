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

  end

  def update

    if @content_type.update(content_type_params)
      redirect_to @content_type, notice: t('flash.notice.save_success')
    else
      render :edit
    end
  end

  def index

    define_argument argument: "description", type: "ilike"
    define_argument argument: "inactive", type: "inactive"
    define_argument_values(:content_type,params_index)

    if @content_type.has_key? :q
         @content_types = current_user.content_genres
         .where(@condition,@value_condition)
         .most_recent
         .page(@content_type[:page])
         .per(PER_PAGE)
    else
        @content_types = {}
    end

  end

  private

    def set_content_type_edit
      @content_type = current_user.content_types.find(params[:id])
    end

    def set_content_type
      @content_type = current_user.content_types.find(params[:id])
    end

    def content_type_params
      params.require(:content_type).permit(:description,:feature)
    end

    def params_index
      return params.require(:content_type).permit(:description,:inactive).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :content_type
      params.permit(:page)
    end
end
