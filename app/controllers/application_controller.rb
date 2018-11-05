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

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :set_locale

  # attr_accessor :user

  #detecting the default language of the browser
  def detect_locale
    langs = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.split(",").map do |lang|
      l, q = lang.split(";q=")
      [l, (q || '1').to_f]
    end

    langs.map do |k,v|
       I18n.available_locales.map do |parsed_locale,_|
         if parsed_locale.to_s==k
           return k
         end
       end
    end

    I18n.default_locale
  end

  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || detect_locale
  end


  def default_url_options
    { :locale => I18n.locale }
  end


  delegate :current_user, :user_signed_in?, :to => :user_session

  helper_method :current_user, :user_signed_in?
  #helper_method :current_user, :user_signed_in?, :current_user_session

  # def current_user_session
  #   if self.user.nil?
  #     self.user=current_user
  #   end
  #
  #   self.user
  # end

  def user_session
    UserSession.new(session)
  end

  def require_authentication
    unless user_signed_in?
      redirect_to new_user_sessions_path,
      :alert => t('flash.alert.needs_login')
    end
  end

  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end
end
