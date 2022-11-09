# frozen_string_literal: true

# Story Job
class DeleteStoriesJob < ApplicationJob
  queue_as :default

  def perform
    users = User.all
    users.map do |user|
      user.stories.map do |story|
        story.destroy if story.present?
      end
    end
  end
end
