class MenuItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :meal

  default_scope -> { includes :meal, :restaurant }
  scope :on_date, ->(date) {
    includes(meal: :meal_type)
      .where(menu_date: date)
  }
end
