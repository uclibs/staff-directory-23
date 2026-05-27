# frozen_string_literal: true

class AddEppnToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :eppn, :string
    add_index :users, :eppn, unique: true
  end
end
