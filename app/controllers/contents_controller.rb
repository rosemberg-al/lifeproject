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

class ContentsController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication

  before_action :set_content, only: [:show]
  before_action :set_content_edit, only: [:edit, :update, :destroy]
  before_action :content_types_list, only: [:edit, :update, :new, :create, :index]
  before_action :content_genres_list, only: [:edit, :update, :new, :create, :index]
  before_action :languages_list, only: [:edit, :update, :new, :create]
  before_action :people_list, only: [:edit, :update, :new, :create]


  def json

   if params.has_key?(:description) && !params[:description].nil?
     description=params[:description]


     @contents=current_user.contents.active.select("id, description as label").where("description ilike '%#{description}%'").limit(30)

     #head :ok
     render :json => @contents
   else
     head :ok
   end

  end

  def new
    @content = current_user.contents.build
    2.times do @content.content_people.build end
    2.times do @content.content_subjects.build end




    #@content.content_people << ContentPerson.new
    #@content.content_people << ContentPerson.new


  end

  def edit

    @content_types.each do |ct|
      if ct.id == @content.content_type_id
        @content.type_feature=ct.feature
        break
      end
    end

    @content.content_subjects.map do |cs|
      cs.subject_description=cs.subject.description
    end

    @summaries = current_user.summaries
    .select("summaries.id,summaries.description, summaries.type_summary")
    .joins(:contents)
    .where("contents.id = ?", params[:id])
    .active
    .most_recent


    @quotations =   @content.quotations
    .select("quotations.id,quotations.indication, quotations.type_quote,quotations.quotation ")
    .active
    .most_recent

    @reviews =   @content.reviews
    .select("reviews.id,reviews.description,reviews.rating,reviews.type_review ")
    .active
    .most_recent


    #to add a new quotation
    @quotation = current_user.quotations.build
    #2.times do @quotation.quotation_people.build end
    @quotation.type_quote=:quote
    @quotation.content_id=@content.id
    @quotation.content_description=@content.description

    @content.content_people.map do |cp|
      cp.person_name=cp.person.name

      @quotation.quotation_people.build(person_id: cp.person.id, person_name_quote: cp.person.name, type_person: cp.type_content_person)
    end


    @show_tab1=!params.has_key?("quotation") ? "class=active" :""
    @show_tab_det1=!params.has_key?("quotation") ? "active" :""

    @show_tab3=params.has_key?("quotation") ? "class=active" :""
    @show_tab_det3=params.has_key?("quotation") ? "active" :""


  end

  def destroy
    if(params.key? :activate)
      @content.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @content.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @content.save
      redirect_to contents_url, notice: message
    else
      render :edit
    end
  end

  def create

    @content = current_user.contents.build(content_params)


    # it was moved to a call back in the model
    # @content.content_people.map do |cp|
    #   cp.user_id=current_user.id
    # end
    #
    # @content.content_subjects.map do |cs|
    #   cs.user_id=current_user.id
    # end

    if @content.save

      redirect_to edit_content_path(@content), notice: t('flash.notice.save_success') #'Content was successfully created.'
    else

      render :new
    end
  end

  def show

  end

  def update

    # it was moved to a call back in the model
    # attributes = content_params.clone
    # if attributes[:content_people_attributes]
    #   attributes[:content_people_attributes].each do |key,cp|
    #     if (!cp[:person_id].empty? && cp[:id].nil?)
    #       cp[:user_id]=current_user.id
    #     end
    #   end
    # end
    #
    # if attributes[:content_subjects_attributes]
    #   attributes[:content_subjects_attributes].each do |key,cs|
    #     if (!cs[:subject_id].empty? && cs[:id].nil?)
    #       cs[:user_id]=current_user.id
    #     end
    #   end
    # end

    if @content.update(content_params)
      redirect_to @content, notice: t('flash.notice.save_success') #notice: 'Content was successfully updated.'
    else
      
      render :edit
    end
  end

  def index

    define_argument argument: "description", type: "ilike", table: "contents"
    define_argument argument: "inactive", type: "inactive", table: "contents"
    define_argument argument: "content_type_id", type: "=", table: "contents"
    define_argument argument: "content_genre_id", type: "=", table: "contents"

    define_argument_values(:content,params_index)

    if @content.has_key? :q
         @contents = current_user.contents
         .select("contents.id,contents.description,content_types.description as ct_description,content_genres.description as cg_description ")
         .joins(:content_type)
         .joins(:content_genre)
         .where(@condition,@value_condition)
         .most_recent
         .page(@content[:page])
         .per(PER_PAGE)
    else
        @contents = {}
    end

  end

  private

    def set_content_edit
      #@content = current_user.contents.find(params[:id])
      @content = current_user.contents.includes(:content_people).includes(:people).find(params[:id])
      #@content =  current_user.contents.includes(:people, :content_people).find(params[:id])
      #@content = Content.find(params[:id])
    end

    def set_content
      #@content = Content.find(params[:id])
      @content = current_user.contents.find params[:id]
    end

    def content_params
      params.require(:content).permit(:description,:content_type_id,:content_genre_id,:synopsis,
      :book_publisher,:book_date_published,
      :movie_company,:movie_date_released,:movie_time,
      :type_feature,:language_id,
      content_people_attributes: [:id,:person_id, :type_content_person, :_destroy, :person_name],
      content_subjects_attributes: [:id,:subject_id, :_destroy, :subject_description])
    end

    def content_types_list
      @content_types=current_user.content_types.active.select("id, description, feature")
    end

    def content_genres_list
      @content_genres=current_user.content_genres.active.select("id, description")
    end

    def languages_list
      @languages=Language.select("id,iso_639_2t,description")
    end

    def people_list
      @people=current_user.people.active.select("id, name")
    end

    def params_index
      return params.require(:content).permit(:description,:inactive,:content_type_id,:content_genre_id).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :content
      params.permit(:page)
    end
end
