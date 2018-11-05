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

class PeopleController < ApplicationController

  PER_PAGE = 50

  before_action :require_authentication
  before_action :set_person, only: [:show]
  before_action :set_person_edit, only: [:edit, :update, :destroy]

  def json

   if params.has_key?(:name) && !params[:name].nil?
     name=params[:name]
     #@people=Person.active.select("id, name").where("name like '%#{name}%'").limit(30)

     @people=current_user.people.active.select("id, name as label").where("name ilike '%#{name}%'").limit(30)
     logger.debug "LISTA: #{@people.inspect}"
     #head :ok
     render :json => @people
   else
     head :ok
   end

  end

  def new
    @person = current_user.people.build


  end

  def edit
  end

  def destroy
    if(params.key? :activate)
      @person.inactivated_at= nil
      message= t 'flash.notice.activate_success'
    else
      @person.inactivated_at= Time.current
      message= t 'flash.notice.inactivate_success'
    end

    if @person.save
      redirect_to people_url, notice: message
    else
      render :edit
    end
  end

  def create

    @person = current_user.people.build(person_params)
    if @person.save
      redirect_to @person, notice: t('flash.notice.save_success') #'Person was successfully created.'
    else
      render :new
    end
  end

  def show
  #  @person = Person.find params[:id]
  end

  def update

    if @person.update(person_params)
      redirect_to @person, notice: t('flash.notice.save_success') #notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def index

    @person={"name"=>'',"inactive"=>'N'}
    if params.has_key? :q
      @person=person_params_index
      @person["page"]=params[:page]
      session[:person]=@person
    else
        if session.has_key? :person
          @person=session[:person]
          params[:page]=@person["page"]
          params[:q]="q"
        end
    end


    if params.has_key? :q
      if @person["inactive"]=="Y"
        @people = current_user.people
        .inactive
        .where([" name ilike ? ","%#{@person["name"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      else
        @people = current_user.people
        .active
        .where([" name ilike ? ","%#{@person["name"]}%"])
        .most_recent
        .page(params[:page])
        .per(PER_PAGE)
      end


    else
        @people = {}
    end

  end

  private

    def set_person_edit
      @person = current_user.people.find(params[:id])
      #@person = Person.find(params[:id])
    end

    def set_person
      #@person = Person.find(params[:id])
      @person = current_user.people.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:name,:type_person,:biography,:main_thoughts)
    end

    def person_params_index
      params.require(:person).permit(:name,:inactive)
    end

end
