class RemovePrefectureFromPlaces < ActiveRecord::Migration[6.1]
  def change
    remove_column :places, :prefecture, :string
  end
end
