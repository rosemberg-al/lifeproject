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

class ReviewsController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication
  before_action :set_review, only: [:show]
  before_action :set_review_edit, only: [:edit, :update, :destroy]



  def new
    @review = current_user.reviews.build

  end

  def edit

    @review.content_description=@review.content.description if @review.content.present?
  end

  def destroy
    if(params.key? :activate)
      @review.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @review.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @review.save
      redirect_to reviews_url, notice: message
    else
      render :edit
    end
  end

  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      redirect_to @review, notice: t('flash.notice.save_success')
    else

      logger.debug "ERROS: #{@review.errors.inspect}"
      render :new
    end
  end

  def show
  end

  def update



    if @review.update(review_params)
      redirect_to @review, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    define_argument argument: "description", type: "ilike", table: "reviews"
    define_argument argument: "inactive", type: "inactive", table: "reviews"
    define_argument argument: "content_id", type: "=", table: "reviews"
    define_argument argument: "content_description", type: "auxiliary"
    define_argument_values(:review,params_index)

    if @review.has_key? :q
         @reviews = current_user.reviews
         .where(@condition,@value_condition)
         .most_recent
         .page(@review[:page])
         .per(PER_PAGE)
    else
        @reviews = {}
    end

  end

  private

    def set_review_edit
      @review = current_user.reviews.find(params[:id])
    end

    def set_review
      @review = current_user.reviews.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:description,:type_review,:review,:rating,:content_id)
    end

    def params_index
      return params.require(:review).permit(:description,:content_id,:content_description,:inactive).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :review
      params.permit(:page)
    end

end
