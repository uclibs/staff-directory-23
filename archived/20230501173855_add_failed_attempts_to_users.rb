# frozen_string_literal: true

class AddFailedAttemptsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: true
  end
end
