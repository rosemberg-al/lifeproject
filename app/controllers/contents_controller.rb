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
  before_action :content_types_list, only: [:edit, :update, :new, :create]
  before_action :content_genres_list, only: [:edit, :update, :new, :create]
  before_action :people_list, only: [:edit, :update, :new, :create]


  def json

   if params.has_key?(:description) && !params[:description].nil?
     description=params[:description]


     @contents=current_user.contents.active.select("id, description as label").where("description ilike '%#{description}%'").limit(30)
     logger.debug "LISTA: #{@contents.inspect}"
     #head :ok
     render :json => @contents
   else
     head :ok
   end

  end

  def new
    @content = current_user.contents.build
    2.times do @content.content_people.build end


    #logger.debug "type: #{@content.content_type.inspect}"

    #@content.content_people << ContentPerson.new
    #@content.content_people << ContentPerson.new

    #@content
    #@content_types=ContentType.active.select("id, description")
    #@content_types.map { |e| puts e.description  }
  end

  def edit

    #@content.attributes[:casa] = "sim"
    ##t=ContentType.select("id,description").where(id: @content.content_type_id).limit(1)
    #type_desc.each do |t|
    ##@content.type_desc=t[0].description
    #end

    @content_types.each do |ct|
      if ct.id == @content.content_type_id
        @content.type_feature=ct.feature
        break
      end
    end

    @content.content_people.map do |cp|
      cp.person_name=cp.person.name
    end

    ##logger.debug "@@@@: #{t.inspect}"
    ##puts "%%%%% #{@content.type_desc}"


  #  @contenta = Content.find(params[:id])
  #  itens=@contenta.content_people
  #  logger.debug "New article: #{itens.inspect}"
  #  itens.map do |item|
    #@content.content_people.map do |item|
    #    logger.debug "Person: #{item.person_id}, Type: #{item.type_content_person}"
    #end
  #  Rails.logger.debug @contenta
  #  puts "AAAA"
  #  puts @contenta
  #  itens.each do |key,cp|
  #      Rails.logger.debug cp.person_id
  #  end
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
    @content.content_people.map do |cp|
      cp.user_id=current_user.id
    end
   logger.debug "OBJECTTTT: #{@content.content_people.inspect}"
    #@content = Content.new(content_params)
    #@content.user_id = current_user.id
    if @content.save

      #debug(params)
      #Rails.logger.debug params[:content_people]#params.inspect
      # content_people=params[:content_people]
      # content_people.each do |kc,cperson|
      #   if(cperson[:person_id]!="" && cperson[:type_content_person]!="")
      #     content_person = current_user.content_people.build
      #     content_person.content=@content
      #     content_person.person_id=cperson[:person_id]
      #     content_person.type_content_person=cperson[:type_content_person]
      #     content_person.save
      #   end
      # end

      redirect_to @content, notice: t('flash.notice.save_success') #'Content was successfully created.'
    else
      logger.debug "ERROS: #{@content.errors.inspect}"
      render :new
    end
  end

  def show
    #@content = Content.find params[:id]
    #@content = current_user.contents.find params[:id]
  end

  def update

    attributes = content_params.clone
    attributes[:content_people_attributes].each do |key,cp|
      if !cp[:person_id].empty?
        cp[:user_id]=current_user.id
      end
    end

    if @content.update(attributes)
      redirect_to @content, notice: t('flash.notice.save_success') #notice: 'Content was successfully updated.'
    else
      logger.debug "ERROS: #{@content.errors.inspect}"
      render :edit
    end
  end

  def index

    @content={"description"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @content=content_params_index
      @content["page"]=params[:page]
      session[:content]=@content
    else
      if session.has_key? :content
        @content=session[:content]
        params[:page]=@content["page"]
        params[:q]="q"
      end
    end


    if params.has_key? :q
      if @content["inactive"]=="Y"
        @contents = current_user.contents
        .inactive
        .where([" description ilike ? ","%#{@content["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @contents = current_user.contents
        .active
        .where([" description ilike ? ","%#{@content["description"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end


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
      :type_feature,
      content_people_attributes: [:id,:person_id, :type_content_person, :_destroy, :person_name])
    end

    def content_types_list
      #@content_types=ContentType.active.select("id, description, feature")
      @content_types=current_user.content_types.active.select("id, description, feature")
    end

    def content_genres_list
      #@content_genres=ContentGenre.active.select("id, description")
      @content_genres=current_user.content_genres.active.select("id, description")
    end

    def people_list
      #@people=Person.active.select("id, name")
      @people=current_user.people.active.select("id, name")
    end

    def content_params_index
      params.require(:content).permit(:description,:inactive)
    end
end