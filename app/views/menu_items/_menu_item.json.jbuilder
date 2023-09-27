json.extract! menu_item, :id, :restaurant_id, :meal_id, :menu_date, :created_at, :updated_at
json.url menu_item_url(menu_item, format: :json)
