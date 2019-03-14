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

class User < ApplicationRecord

  #attr_accessor :bio,:email,:full_name,:password,:password_confirmation
  #default_scope{ where('confirmed_at IS NOT NULL') }

  scope :confirmed, -> {
     where('confirmed_at IS NOT NULL')
  }

  mount_uploader :picture, PictureUserUploader

  has_many :subjects , :dependent => :destroy
  has_many :content_genres , :dependent => :destroy
  has_many :content_types , :dependent => :destroy
  has_many :contents , :dependent => :destroy
  has_many :people , :dependent => :destroy
  has_many :content_people , :dependent => :destroy
  has_many :summaries , :dependent => :destroy
  has_many :quotations , :dependent => :destroy
  has_many :content_subjects , :dependent => :destroy
  has_many :reviews , :dependent => :destroy


  def self.authenticate(email, password)
    confirmed.find_by_email(email).try(:authenticate, password)
  end

  before_create :generate_token
  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end


  def confirm!
    return true if confirmed? #se já foi confirmado retorna true
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present? # funcao present?, retorna true se tiver qualquer valor
  end


  validates_presence_of :email, :full_name #, :password
  #validates_confirmation_of :password
  validates_length_of :bio, :minimum => 5, :allow_blank => false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email

  has_secure_password
end
