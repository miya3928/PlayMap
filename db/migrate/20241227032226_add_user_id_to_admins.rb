class AddUserIdToAdmins < ActiveRecord::Migration[6.1]
  def change
    # 一時的にデフォルト値を設定してカラムを追加
    add_column :admins, :user_id, :integer, null: false, default: 0

    # 必要に応じて、既存のレコードに適切なuser_idを設定
    Admin.update_all(user_id: 1) # 例: 全てのレコードを user_id 1 に設定

    # デフォルト値を削除して制約を保持
    change_column_default :admins, :user_id, nil
    add_foreign_key :admins, :users, column: :user_id
  end
end
