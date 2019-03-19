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

class Content < ApplicationRecord

  scope :most_recent, -> {
     order 'created_at desc'
  }

  scope :active, -> {
    where(inactivated_at: nil)
  }

  scope :inactive, -> {
    where.not(inactivated_at: nil)
  }

  validates_presence_of :description, :synopsis, :content_type_id, :content_genre_id
  validates_length_of :description, :minimum => 3, :allow_blank => false
  validates_length_of :synopsis, :minimum => 3, :allow_blank => false

  belongs_to :user

  has_many :content_people
  has_many :people, through: :content_people
  #belongs_to :content_type


  has_many :summary_contents
  has_many :summaries, through: :summary_contents

  has_many :content_subjects
  has_many :subjects, through: :content_subjects

  has_many :quotations


  accepts_nested_attributes_for :content_people, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :content_subjects, reject_if: :all_blank, allow_destroy: true



  #virtual attributes
  attr_accessor :type_feature

end
