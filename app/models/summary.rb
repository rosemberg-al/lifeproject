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

class Summary < ApplicationRecord

  enum summary_type: { summary: "Summary", annotation: "Annotation", article: "Article", report: "Report",
    text: "Text", script: "Script", tutorial: "Tutorial"}

  scope :most_recent, -> {
     order 'summaries.created_at desc'
  }

  scope :active, -> {
    where(inactivated_at: nil)
  }

  scope :inactive, -> {
    where.not(inactivated_at: nil)
  }

  validates_presence_of :description, :type_summary
  validates_length_of :description, :minimum => 3, :allow_blank => false

  belongs_to :user


  has_many :summary_contents
  has_many :contents, through: :summary_contents
  accepts_nested_attributes_for :summary_contents, reject_if: :all_blank, allow_destroy: true


  has_many :summary_people
  has_many :people, through: :summary_people
  accepts_nested_attributes_for :summary_people, reject_if: :all_blank, allow_destroy: true

end
