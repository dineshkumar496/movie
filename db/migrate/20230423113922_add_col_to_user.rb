# frozen_string_literal: true

class AddColToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
