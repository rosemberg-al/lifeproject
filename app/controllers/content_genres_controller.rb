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

class ContentGenresController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication

  before_action :set_content_genre, only: [:show]
  before_action :set_content_genre_edit, only: [:edit, :update, :destroy]

  def new
    @content_genre = current_user.content_genres.build
  end

  def edit
  end

  def destroy
    if(params.key? :activate)
      @content_genre.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @content_genre.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @content_genre.save
      redirect_to content_genres_url, notice: message
    else
      render :edit
    end
  end

  def create

    @content_genre = current_user.content_genres.build(content_genre_params)

    if @content_genre.save
      redirect_to @content_genre, notice: t('flash.notice.save_success')
    else
      render :new
    end
  end

  def show

  end

  def update

    if @content_genre.update(content_genre_params)
      redirect_to @content_genre, notice: t('flash.notice.save_success')
    else
      render :edit
    end
  end

  def index

    define_argument argument: "description", type: "ilike", table: "content_genres"
    define_argument argument: "inactive", type: "inactive", table: "content_genres"
    define_argument_values(:content_genre,params_index)

    if @content_genre.has_key? :q
         @content_genres = current_user.content_genres
         .where(@condition,@value_condition)
         .most_recent
         .page(@content_genre[:page])
         .per(PER_PAGE)
    else
        @content_genres = {}
    end

  end

  private

    def set_content_genre_edit
      @content_genre = current_user.content_genres.find(params[:id])
    end

    def set_content_genre
      @content_genre = current_user.content_genres.find(params[:id])
    end

    def content_genre_params
      params.require(:content_genre).permit(:description)
    end

    def params_index
      return params.require(:content_genre).permit(:description,:inactive).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :content_genre
      params.permit(:page)
    end
end
