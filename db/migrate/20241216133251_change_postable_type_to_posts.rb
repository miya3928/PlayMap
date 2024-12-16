class ChangePostableTypeToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :postable_type, :string
  end
end
