# frozen_string_literal: true

class DropDepartmentsCopy < ActiveRecord::Migration[6.1]
  def change
    drop_table :departments_copy if table_exists?(:departments_copy)
  end
end
