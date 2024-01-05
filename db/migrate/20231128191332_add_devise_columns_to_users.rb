class AddDeviseColumnsToUsers < ActiveRecord::Migration[6.1]
      def change
        add_column :users, :failed_attempts, :integer, default: 0, null: false unless column_exists?(:users, :failed_attempts)
        add_column :users, :unlock_token, :string unless column_exists?(:users, :unlock_token)
        add_column :users, :locked_at, :datetime unless column_exists?(:users, :locked_at)
        # Add similar checks for any other columns you need to add
          end
        end
