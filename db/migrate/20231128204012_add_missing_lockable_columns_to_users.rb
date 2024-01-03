# frozen_string_literal: true

class AddMissingLockableColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false unless column_exists? :users, :failed_attempts

    unless column_exists? :users, :unlock_token
      add_column :users, :unlock_token, :string
      add_index :users, :unlock_token, unique: true
    end

    # Add the 'locked_at' column if it's missing (assuming your production will need it)
    return if column_exists? :users, :locked_at

    add_column :users, :locked_at, :datetime
  end
end
