# frozen_string_literal: true

class AddNameToDepartments < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :name, :string
  end
end
