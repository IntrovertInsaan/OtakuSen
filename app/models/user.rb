# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :forum_threads, dependent: :destroy
  has_many :forum_posts, dependent: :destroy

  has_many :media_items, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_items, through: :favorites, source: :media_item

  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
