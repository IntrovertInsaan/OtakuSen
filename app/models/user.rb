# frozen_string_literal: true

class User < ApplicationRecord
  # This allows us to access the raw token ONE TIME after creation to show the user
  attr_reader :raw_api_token

  # Use our new hashing logic before creating a new user
  before_create :generate_and_hash_api_token

  # Include default devise modules.
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

  # Class method to find a user by their raw token (Hashed lookup)
  def self.authenticate_by_token(raw_token)
    return nil if raw_token.blank?
    digest = Digest::SHA256.hexdigest(raw_token)
    find_by(hashed_api_token: digest)
  end

  private

  def generate_and_hash_api_token
    # SecureRandom.hex(32) provides 256-bit entropy for high security
    @raw_api_token = SecureRandom.hex(32)
    self.hashed_api_token = Digest::SHA256.hexdigest(@raw_api_token)
  end
end
