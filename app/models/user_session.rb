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

class UserSession
  include ActiveModel::Model

  attr_accessor :email, :password

  validates_presence_of :email, :password

  def persisted?
    false
  end


  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end


  def authenticate
    user = User.authenticate(@email, @password)
    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end


  def store(user)
    @session[:user_id] = user.id
  end

  def destroy
    @session[:user_id] = nil
  end


  def current_user
    User.find(@session[:user_id])
  end

  def user_signed_in?
    @session[:user_id].present?
  end

end
