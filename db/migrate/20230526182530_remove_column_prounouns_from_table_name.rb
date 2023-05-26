class RemoveColumnProunounsFromTableName < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :pronouns, :pronouns
  end
end
