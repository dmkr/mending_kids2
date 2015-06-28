json.array!(@missions) do |mission|
  json.extract! mission, :id, :location
  json.url mission_url(mission, format: :json)
end
