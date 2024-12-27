class AddUserIdToAdmins < ActiveRecord::Migration[6.0]
  def up
    add_column :admins, :user_id, :bigint, null: false, default: 0
    add_foreign_key :admins, :users, column: :user_id
  end

  def down
    remove_foreign_key :admins, column: :user_id
    remove_column :admins, :user_id
  end
end