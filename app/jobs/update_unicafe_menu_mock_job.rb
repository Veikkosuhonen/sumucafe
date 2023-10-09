# frozen_string_literal: true

class UpdateUnicafeMenuMockJob
  def self.perform
    Time.use_zone("Helsinki") {

      data_file = File.read(Rails.root.join("app", "jobs", "concerns", "unicafe_mock_data.json"))
      data = JSON.parse(data_file)

      UpdateUnicafeMenu.update_with(data)
    }

    puts "Updated Unicafe menu"
  end
end
