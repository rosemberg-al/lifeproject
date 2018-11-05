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

class SignupMailer < ActionMailer::Base
  default :from => 'no-reply@lifeproject.io'

  def confirm_email(user)
    @user = user
    @confirmation_link = confirmation_url({:token => @user.confirmation_token ,:locale => I18n.locale })
    mail({
      :to => user.email,
      :bcc => ['sign ups <signups@lifeproject.io>'],
      :subject => I18n.t('signup_mailer.confirm_email.subject')
      })
  end
end
