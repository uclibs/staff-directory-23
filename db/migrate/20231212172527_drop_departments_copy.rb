class DropDepartmentsCopy < ActiveRecord::Migration[6.1]
  def change
    drop_table :departments_copy
  end
end
