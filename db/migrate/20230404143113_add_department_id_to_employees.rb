class AddDepartmentIdToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :department, null: false, foreign_key: true
  end
end
