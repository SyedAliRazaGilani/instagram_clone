# frozen_string_literal: true

class AddFollowerToFollowers < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :follower, :integer, null: false
  end
end
