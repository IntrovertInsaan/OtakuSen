class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :media_items, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_items, through: :favorites, source: :media_item

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
