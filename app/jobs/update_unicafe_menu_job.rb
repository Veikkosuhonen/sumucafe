require "json"

class UpdateUnicafeMenuJob < ApplicationJob
  queue_as :default

  def perform
    Time.use_zone("Helsinki") {
      datafile = File.open "./test/fixtures/apiresponse.json"

      data = JSON.load datafile

      datafile.close

      data.each { |restaurant_data|
        name = restaurant_data["title"]

        restaurant = Restaurant.find_or_create_by({
                                                    :name => name,
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

            menu_item = MenuItem.find_or_create_by({
              :meal_id => meal.id,
              :restaurant_id => restaurant.id,
              :menu_date => date,
                                                   })
          }
        }
      }
    }

    puts "Updated Unicafe menu"
  end
end
