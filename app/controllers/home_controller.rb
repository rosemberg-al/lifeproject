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

class HomeController < ApplicationController

  before_action :require_authentication

  def index
    @random=rand(5)
    @author=["William W. Purkey","Bernard M. Baruch","Mae West","Mahatma Gandhi","Robert Frost"]
    @quotation=["You've gotta dance like there's nobody watching, Love like you'll never be hurt, Sing like there's nobody listening, And live like it's heaven on earth.",
                "Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.",
                "You only live once, but if you do it right, once is enough.",
                "Be the change that you wish to see in the world.",
                "In three words I can sum up everything I've learned about life: it goes on."]

  end
end
