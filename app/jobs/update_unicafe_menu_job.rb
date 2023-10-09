require "json"

class UpdateUnicafeMenuJob < ApplicationJob

  def perform
    Time.use_zone("Helsinki") {

      data = fetch_unicafe_data

      UpdateUnicafeMenu.update_with(data)
    }

    puts "Updated Unicafe menu"
  end

  def fetch_unicafe_data
    url = "https://unicafe.fi/wp-json/swiss/v1/restaurants/?lang=fi"
    response = HTTParty.get url
    response.parsed_response
  end
end
