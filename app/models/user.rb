# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :username, presence: true
  validates :mobilenumber, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :stories
  has_many :followers
  has_many :likes, dependent: :destroy

  has_one_attached :avatar

  validates :avatar, content_type: ['image/png', 'image/jpeg']

  scope :search, ->(query) { where('name ILIKE ?', query) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }
end
