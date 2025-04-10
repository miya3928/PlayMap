class AddAddressDetailsToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :prefecture, :string
    add_column :places, :zipcode, :string
    add_column :places, :city, :string
    add_column :places, :street, :string
  end
end
