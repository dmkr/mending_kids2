json.array!(@inventories) do |inventory|
  json.extract! inventory, :id, :item_description, :quantity
  json.url inventory_url(inventory, format: :json)
end
