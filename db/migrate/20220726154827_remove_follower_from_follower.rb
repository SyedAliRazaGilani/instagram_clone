# frozen_string_literal: true

class RemoveFollowerFromFollower < ActiveRecord::Migration[5.2]
  def change
    remove_column :followers, :follower, :integer
  end
end
