class Meal < ApplicationRecord
  has_many :menu_items
  has_many :ratings
  belongs_to :meal_type
end
