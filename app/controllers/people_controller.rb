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

  PER_PAGE = 1

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

    argument={name: :person,
              arg:[{argument: "name", type: "ilike"},{argument: "type_person", type: "="},{argument: "inactive", type: "inactive"}],
              values: person_params_index,
              page: params[:page]}

    result=mount_argument(argument)

    @person=result[:params]

   if (@person.has_key?(:q))

        @people = current_user.people
        .where(result[:condition],result[:value])
        .most_recent
        .page(@person[:page])
        .per(PER_PAGE)

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
      params.require(:person).permit(:name,:inactive,:type_person).merge(params.permit(:q)).merge(params.permit(:page)).to_h if params.has_key? :person

      # params.permit(:q) #if params.has_key? :person
       #a.merge(params.permit(:q))

       #par<<params.permit(:q)
     end

end
