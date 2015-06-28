json.array!(@donations) do |donation|
  json.extract! donation, :id, :item_description, :brand, :lot_number, :expiration_date, :fair_market_value, :mk_cost, :total_in_kind_value, :donor_id, :quantity, :inventory_id
  json.url donation_url(donation, format: :json)
end
