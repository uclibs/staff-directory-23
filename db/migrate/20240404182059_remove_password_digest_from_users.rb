# frozen_string_literal: true

class RemovePasswordDigestFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
  end
end
