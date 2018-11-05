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

class ContentSummariesController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication
  before_action :set_content_summary, only: [:show]
  before_action :set_content_summary_edit, only: [:edit, :update, :destroy]



  def new
    @content_summary = current_user.content_summaries.build
  end

  def edit

    @content_summary.content_description=@content_summary.content.description

  end

  def destroy
    if(params.key? :activate)
      @content_summary.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @content_summary.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @content_summary.save
      redirect_to content_summaries_url, notice: message
    else
      render :edit
    end
  end

  def create
    @content_summary = current_user.content_summaries.build(content_summary_params)
    if @content_summary.save
      redirect_to @content_summary, notice: t('flash.notice.save_success') #'Person was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def update

    if @content_summary.update(content_summary_params)
      redirect_to @content_summary, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    @content_summary={"description"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @content_summary=content_summary_params_index
      @content_summary["page"]=params[:page]
      session[:content_summary]=@content_summary
    else
        if session.has_key? :content_summary
          @content_summary=session[:content_summary]
          params[:page]=@content_summary["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @content_summary["inactive"]=="Y"
        @content_summaries = current_user.content_summaries
        .inactive
        .where([" description ilike ? ","%#{@content_summary["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @content_summaries = current_user.content_summaries
        .active
        .where([" description ilike ? ","%#{@content_summary["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end


    else
        @content_summaries = {}
    end

  end

  private

    def set_content_summary_edit
      @content_summary = current_user.content_summaries.find(params[:id])
    end

    def set_content_summary
      @content_summary = current_user.content_summaries.find(params[:id])
    end

    def content_summary_params
      params.require(:content_summary).permit(:description,:type_content_summary,:content_id,:text,:content_description)
    end

    def content_summary_params_index
      params.require(:content_summary).permit(:description,:inactive)
    end

end
