class MenuItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :meal

  default_scope -> { includes :meal }
end
