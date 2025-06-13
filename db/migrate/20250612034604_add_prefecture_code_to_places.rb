class AddPrefectureCodeToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :prefecture_code, :integer
  end
end
