json.array!(@donors) do |donor|
  json.extract! donor, :id, :first_name, :last_name, :company_name, :phone_number
  json.url donor_url(donor, format: :json)
end
