class CreateReviewLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :review_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end

    add_index :review_likes, [:user_id, :review_id], unique: true
  end
end
