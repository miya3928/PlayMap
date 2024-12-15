class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
