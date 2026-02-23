class EnsureUsersIdAutoIncrement < ActiveRecord::Migration[8.1]
  def up
    return unless connection.adapter_name.match?(/mysql/i)
    # Fix "Field 'id' doesn't have a default value" when inserting users (e.g. seed_test_user on MySQL).
    execute <<-SQL.squish
      ALTER TABLE users MODIFY id BIGINT NOT NULL AUTO_INCREMENT
    SQL
  end

  def down
    # No safe way to remove AUTO_INCREMENT; leave as-is.
    raise ActiveRecord::IrreversibleMigration
  end
end
