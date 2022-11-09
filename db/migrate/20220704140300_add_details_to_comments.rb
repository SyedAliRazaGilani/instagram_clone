# frozen_string_literal: true

class AddDetailsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :likes, :integer
  end
end
