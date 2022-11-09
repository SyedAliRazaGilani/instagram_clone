# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :user

  validates :user_id, :follower_id, presence: true

  after_initialize :falsify_friend

  def falsify_friend
    self.friend = false
  end
end
