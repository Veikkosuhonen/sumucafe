class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validates :score, numericality: { minimum: 1, maximum: 5 }
end
