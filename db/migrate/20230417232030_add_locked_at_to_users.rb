class AddLockedAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :locked_at, :datetime
    add_index :users, :locked_at
  end
end
