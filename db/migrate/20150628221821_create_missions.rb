class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :location

      t.timestamps
    end
  end
end
