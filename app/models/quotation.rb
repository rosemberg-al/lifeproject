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

class Quotation < ApplicationRecord

  enum quotation_type: { insight: "insight", quote: "quote"}
  enum quotation_indication: { avoid: "avoid", follow: "follow"}

  scope :most_recent, -> {
     order ' quotations.created_at desc'
  }

  scope :active, -> {
    where(inactivated_at: nil)
  }

  scope :inactive, -> {
    where.not(inactivated_at: nil)
  }

  validates_presence_of :quotation, :type_quote
  validates_length_of :quotation, :minimum => 3, :allow_blank => false

  belongs_to :user
  belongs_to :content, optional: true # this parameter is to allow null value

  has_many :quotation_people
  has_many :people, through: :quotation_people

  accepts_nested_attributes_for :quotation_people, reject_if: :all_blank, allow_destroy: true

  #virtual attributes
  attr_accessor :content_description

end
