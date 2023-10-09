json.extract! meal_type, :id, :name, :color, :price, :created_at, :updated_at
json.url meal_type_url(meal_type, format: :json)
