json.array!(@mission_inventories) do |mission_inventory|
  json.extract! mission_inventory, :id
  json.url mission_inventory_url(mission_inventory, format: :json)
end
