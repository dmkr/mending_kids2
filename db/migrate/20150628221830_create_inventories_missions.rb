class CreateInventoriesMissions < ActiveRecord::Migration
  def change
    create_table :inventories_missions do |t|
      t.belongs_to :inventory, index: true
      t.belongs_to :mission, index: true
    end
  end
end
