require "json"

class UpdateUnicafeMenuJob < ApplicationJob

  def perform
    Time.use_zone("Helsinki") {

      data = fetch_unicafe_data

      # Set all menu items to canceled
      MenuItem.update_all(is_canceled: true)

      data.each { |restaurant_data|
        location_datas = restaurant_data["location"]
        return unless location_datas.length > 0

        location_name = location_datas[0]["name"]
        puts location_name

        location = Location.find_or_create_by({
          :name => location_name
                                              })


        name = restaurant_data["title"]

        restaurant = Restaurant.find_or_create_by({
                                                    :name => name,
                                                    :location_id => location.id
                                                  })

        restaurant_data["menuData"]["menus"].each { |menu_data|
          menu_data["data"].each { |menu_item_data|
            meal_name = menu_item_data["name"]


            meal = Meal.find_or_create_by({
              :name => meal_name
                                          })

            menu_date_string = menu_data["date"]
            menu_date_string = menu_date_string.slice(3, menu_date_string.length)

            date = Date.strptime(menu_date_string, "%d.%m.")

            existing_menu_item = MenuItem.find_by({
                                                    :restaurant_id => restaurant.id,
                                                    :meal_id => meal.id,
                                                    :menu_date => date,
                                                  })
            # If menu item already exists, un-cancel it
            if existing_menu_item
              existing_menu_item.update({
                                          :is_canceled => false
                                        })
            else
              MenuItem.create({
                                :restaurant_id => restaurant.id,
                                :meal_id => meal.id,
                                :menu_date => date,
                                :is_canceled => false
                              })
            end
          }
        }
      }
    }

    puts "Updated Unicafe menu"
  end

  def fetch_unicafe_data
    url = "https://unicafe.fi/wp-json/swiss/v1/restaurants/?lang=fi"
    response = HTTParty.get url
    response.parsed_response
  end
end
