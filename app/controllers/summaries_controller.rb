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

class SummariesController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication
  before_action :set_summary, only: [:show]
  before_action :set_summary_edit, only: [:edit, :update, :destroy]



  def new
    @summary = current_user.summaries.build
  end

  def edit

    @summary.content_description=@summary.content.description

  end

  def destroy
    if(params.key? :activate)
      @summary.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @summary.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @summary.save
      redirect_to summaries_url, notice: message
    else
      render :edit
    end
  end

  def create
    @summary = current_user.summaries.build(summary_params)
    if @summary.save
      redirect_to @summary, notice: t('flash.notice.save_success') #'Person was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def update

    if @summary.update(summary_params)
      redirect_to @summary, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    @summary={"description"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @summary=summary_params_index
      @summary["page"]=params[:page]
      session[:summary]=@summary
    else
        if session.has_key? :summary
          @summary=session[:summary]
          params[:page]=@summary["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @summary["inactive"]=="Y"
        @summaries = current_user.summaries
        .inactive
        .where([" description ilike ? ","%#{@summary["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @summaries = current_user.summaries
        .active
        .where([" description ilike ? ","%#{@summary["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end


    else
        @summaries = {}
    end

  end

  private

    def set_summary_edit
      @summary = current_user.summaries.find(params[:id])
    end

    def set_summary
      @summary = current_user.summaries.find(params[:id])
    end

    def summary_params
      params.require(:summary).permit(:description,:type_summary,:content_id,:text,:content_description)
    end

    def summary_params_index
      params.require(:summary).permit(:description,:inactive)
    end

end
