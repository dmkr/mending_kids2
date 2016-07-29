class AddExpirationDate < ActiveRecord::Migration
  def change

  	add_column :mission_inventories, :expiration_date, :datetime 

  end
end
