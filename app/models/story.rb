# frozen_string_literal: true

# Story Model
class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :caption, presence: true

  after_commit :delete_stories_after_1_hour

  private

  def delete_stories_after_1_hour
    DeleteStoriesJob.set(wait: 24.hours).perform_later
  end

end
