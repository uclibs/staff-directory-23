class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :lastname
      t.string :firstname
      t.string :email
      t.string :phone
      t.string :title
      t.string :department
      t.string :pronouns

      t.timestamps
    end
  end
end
