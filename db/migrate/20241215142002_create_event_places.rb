class CreateEventPlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :event_places do |t|
      t.references :place, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
