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

class ContentPerson < ApplicationRecord

  enum type_content_person: {author: "author",director: "director",writer: "writer",actor: "actor",speaker: "speaker"}
  #enum type_artist: { author: "Author", director: "Director",writer: "Writer",actor: "Actor",speaker: "Speaker"}

  scope :active, -> {
    where(inactivated_at: nil)
  }

  scope :inactive, -> {
    where.not(inactivated_at: nil)
  }

  #validates_presence_of :content_id, :person_id
  #não ser dever colocar o id do mestre na validação da tela de mestre detalhe
  validates_presence_of  :person_id, :type_content_person

  belongs_to :user
  belongs_to :person
  belongs_to :content


  #virtual attributes
  attr_accessor :person_name

end
