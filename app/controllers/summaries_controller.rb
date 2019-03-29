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
    2.times do @summary.summary_contents.build end
    2.times do @summary.summary_people.build end
  end

  def edit

    @summary.summary_people.map do |sp|
      sp.person_name=sp.person.name
    end

    @summary.summary_contents.map do |s|
      s.content_description=s.content.description
    end

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

    @summary.summary_contents.map do |cp|
      cp.user_id=current_user.id
    end

    @summary.summary_people.map do |sp|
      sp.user_id=current_user.id
    end

    if @summary.save
      redirect_to edit_summary_path(@summary), notice: t('flash.notice.save_success') #'Person was successfully created.'
    else

      logger.debug "ERROS: #{@summary.errors.inspect}"
      render :new
    end
  end

  def show
  end

  def save_text
    #logger.debug "TEXTOOO #{params["text"]} - #{params["id"]}"

    summary = current_user.summaries.find(params[:id])
    summary.text=params["text"]

    if(summary.save)
      render json: { status: "success" }
    else
      render json: { status: "error" }
    end
  end

  def update

    attributes = summary_params.clone
    unless attributes[:summary_contents_attributes].nil?
      attributes[:summary_contents_attributes].each do |key,cp|
        if (!cp[:content_id].empty? && cp[:id].nil?)
          cp[:user_id]=current_user.id
        end
      end
    end

    unless attributes[:summary_people_attributes].nil?
      attributes[:summary_people_attributes].each do |key,cp|
        if (!cp[:person_id].empty? && cp[:id].nil?)
          cp[:user_id]=current_user.id
        end
      end
    end


    if @summary.update(attributes)
      redirect_to @summary, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    define_argument argument: "description", type: "ilike", table: "summaries"
    define_argument argument: "inactive", type: "inactive", table: "summaries"
    define_argument_values(:summary,params_index)

    if @summary.has_key? :q
         @summaries = current_user.summaries
         .where(@condition,@value_condition)
         .most_recent
         .page(@summary[:page])
         .per(PER_PAGE)
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
      params.require(:summary).permit(:description,:type_summary,:text,
      summary_people_attributes: [:id,:person_id, :type_person, :_destroy, :person_name],
      summary_contents_attributes: [:id,:content_id, :_destroy, :content_description])
    end

    def params_index
      return params.require(:summary).permit(:description,:inactive).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :summary
      params.permit(:page)
    end

end
