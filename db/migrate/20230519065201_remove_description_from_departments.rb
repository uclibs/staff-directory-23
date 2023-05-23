# frozen_string_literal: true

class RemoveDescriptionFromDepartments < ActiveRecord::Migration[6.1]
  def change
    remove_column :departments, :description, :string
  end
end
