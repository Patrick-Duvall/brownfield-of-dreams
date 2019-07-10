# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friends
  has_many :friended_users, through: :friends

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def active?
    active
  end

  def activate
    update(active: true)
  end

end
