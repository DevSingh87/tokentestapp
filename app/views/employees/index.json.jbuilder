json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :email, :date_of_birth, :location, :phone_number
  json.url employee_url(employee, format: :json)
end
