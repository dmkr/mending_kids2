class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :item_description
      t.string :brand
      t.string :lot_number
      t.date :expiration_date
      t.decimal :fair_market_value
      t.decimal :mk_cost
      t.decimal :total_in_kind_value
      t.references :donor, index: true
      t.integer :quantity
      t.references :inventory, index: true

      t.timestamps
    end
  end
end
