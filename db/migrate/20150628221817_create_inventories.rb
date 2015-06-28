class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :item_description
      t.integer :quantity

      t.timestamps
    end
  end
end
