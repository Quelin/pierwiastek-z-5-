json.array!(@clients) do |client|
  json.extract! client, :id, :name, :description, :address, :email, :phone
  json.url client_url(client, format: :json)
end
