class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :phone_number

      t.timestamps
    end
  end
end
