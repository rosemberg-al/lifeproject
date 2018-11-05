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
    #@content_genre = ContentGenre.find params[:id]
  end

  def update

    if @content_genre.update(content_genre_params)
      redirect_to @content_genre, notice: t('flash.notice.save_success')
    else
      render :edit
    end
  end

  def index

    @content_genre={"description"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @content_genre=content_genre_params_index
      @content_genre["page"]=params[:page]
      session[:content_genre]=@content_genre
    else
        if session.has_key? :content_genre
          @content_genre=session[:content_genre]
          params[:page]=@content_genre["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @content_genre["inactive"]=="Y"
        @content_genres = current_user.content_genres
        .inactive
        .where([" description ilike ? ","%#{@content_genre["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @content_genres = current_user.content_genres
        .active
        .where([" description ilike ? ","%#{@content_genre["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end

    else
        @content_genres = {}
    end

  end

  private

    def set_content_genre_edit
      @content_genre = current_user.content_genres.find(params[:id])
    end

    def set_content_genre
      #@content_genre = ContentGenre.find(params[:id])
      @content_genre = current_user.content_genres.find(params[:id])
    end

    def content_genre_params
      params.require(:content_genre).permit(:description)
    end

    def content_genre_params_index
      params.require(:content_genre).permit(:description,:inactive)
    end
end
