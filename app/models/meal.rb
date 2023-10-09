class Meal < ApplicationRecord
  has_many :menu_items
  belongs_to :meal_type
end
