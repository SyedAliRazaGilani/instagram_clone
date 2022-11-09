# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :caption, presence: true

  validates :images, content_type: ['image/png', 'image/jpeg'], limit: { min: 1, max: 10 }

end
