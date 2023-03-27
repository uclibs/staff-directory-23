class CreateAddData < ActiveRecord::Migration[6.1]
  def change
    create_table :add_data do |t|

      t.timestamps
    end
  end
end
