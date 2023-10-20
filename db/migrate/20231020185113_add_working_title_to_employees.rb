class AddWorkingTitleToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :working_title, :string
  end
end
