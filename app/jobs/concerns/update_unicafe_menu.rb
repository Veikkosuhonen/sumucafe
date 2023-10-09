# frozen_string_literal: true

class UpdateUnicafeMenu
  def self.update_with(json_data)
    # Set all menu items to canceled
    MenuItem.update_all(is_canceled: true)

    json_data.each { |restaurant_data|
      location_datas = restaurant_data["location"]
      return unless location_datas.length > 0

      location_name = location_datas[0]["name"]
      location = Location.find_or_create_by(name: location_name)

      restaurant_name = restaurant_data["title"]
      restaurant = Restaurant.find_or_create_by(name: restaurant_name, location: location)

      restaurant_data["menuData"]["menus"].each { |menu_data|
        menu_data["data"].each { |menu_item_data|
          meal_type_name = menu_item_data["price"]["name"]
          meal_type_price = menu_item_data["price"]["value"]
          meal_type = MealType.find_by(name: meal_type_name)
          if meal_type.nil?
            meal_type = MealType.create(name: meal_type_name, price: meal_type_price)
          else
            meal_type.update(price: meal_type_price)
          end

          meal_name = menu_item_data["name"]
          meal = Meal.find_by(name: meal_name)
          if meal.nil?
            meal = Meal.create(name: meal_name, meal_type: meal_type)
          else
            meal.update(meal_type: meal_type)
          end

          menu_date_string = menu_data["date"]
          menu_date_string = menu_date_string.slice(3, menu_date_string.length)
          date = Date.strptime(menu_date_string, "%d.%m.")
          menu_item = MenuItem.find_by(
            restaurant: restaurant,
            meal: meal,
            menu_date: date,
          )

          # If menu item already exists, un-cancel it
          if menu_item.nil?
            MenuItem.create(
              restaurant: restaurant,
              meal: meal,
              menu_date: date,
              is_canceled: false
            )
          else
            menu_item.update(is_canceled: false)
          end
        }
      }
    }
  end
end
