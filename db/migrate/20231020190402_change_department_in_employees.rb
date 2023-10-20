class ChangeDepartmentInEmployees < ActiveRecord::Migration[6.1]
  def change
    # Remove the old column
    remove_column :employees, :department, :string

    # Add the new reference column
    add_reference :employees, :department, foreign_key: true
  end
end
