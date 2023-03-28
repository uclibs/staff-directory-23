class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name

      t.timestamps
    end

    add_reference :employees, :department, foreign_key: true
    change_column_null :employees, :department, false
  end
end
