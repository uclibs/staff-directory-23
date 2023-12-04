class RemoveDepartmentFromEmployees < ActiveRecord::Migration[6.0]
  def change
    remove_column :employees, :department, :string
  end
end
