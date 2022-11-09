# frozen_string_literal: true

class AddUserRefToFollowers < ActiveRecord::Migration[5.2]
  def change
    add_reference :followers, :user, foreign_key: true, null: false
  end
end
