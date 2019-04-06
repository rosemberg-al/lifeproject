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

class UsersController < ApplicationController

  layout :layout_set
  #layout "base"
  #before_action :layout_set
  before_action :require_no_authentication, :only => [:new, :create]
  before_action :can_change, :only => [:edit,:update]



  def new
    @user = User.new
  end


  def create


    
    @user = User.new(user_params)
    if @user.save
      SignupMailer.confirm_email(@user).deliver #enviando email de cadastro
      #redirect_to @user, :notice => 'Cadastro criado com sucesso!'
      redirect_to user_path(@user, :new=> 'S'), :notice => 'Cadastro criado com sucesso!'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, :notice => 'Cadastro atualizado com sucesso!'
    else
      render :edit
    end
  end

  def show
    if !params.has_key?(:new)
      require_authentication
    end

    @user = User.find params[:id]

    if params.has_key?(:new)
      render :sing_show
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:bio,:email,:full_name,:password,:password_confirmation,:picture)
    end


    def can_change

      unless user_signed_in? && current_user==user
        redirect_to user_path(params[:id])
      end
    end

    def user
      @user||= User.find(params[:id])
    end


    def layout_set


      if (params.has_key?(:new) || params[:action]=="new" || params[:action]=="create")
      #if (params.has_key(:new) || current_page?(action: 'new') || current_page?(action: 'create'))
      #the method current_page only works on the view
         "base"
      else
         "application"
      end
    end

end
