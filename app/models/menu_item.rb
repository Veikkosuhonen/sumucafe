class MenuItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :meal
end
