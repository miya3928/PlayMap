class ChangeScoreToFloatInReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :score, :float
  end
end
