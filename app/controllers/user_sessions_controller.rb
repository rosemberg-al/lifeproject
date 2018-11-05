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

class UserSessionsController < ApplicationController

  layout "base"

  before_action :require_no_authentication, :only => [:new, :create]
  before_action :require_authentication, :only => :destroy


  def new
    @session = UserSession.new session
  end

  def create
    @session = UserSession.new(session, params[:user_session])

    if @session.authenticate
      # Não esqueça de adicionar a chave no i18n!
      redirect_to root_path, :notice => t('flash.notice.signed_in')
      #redirect_to new_user_sessions_path, :notice => t('flash.notice.signed_in')
    else
      render :new
    end
  end

  def destroy
    user_session.destroy
    redirect_to new_user_sessions_path, :notice => t('flash.notice.signed_out')
  end
end
