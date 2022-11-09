# frozen_string_literal: true

class AddFriendToFollower < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :friend, :boolean
  end
end
