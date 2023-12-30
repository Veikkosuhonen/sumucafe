class Meal < ApplicationRecord
  has_many :menu_items
  has_many :ratings
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  belongs_to :meal_type
  validates :name, presence: true, uniqueness: true

  def score
    @score ||= ratings.average(:score).to_f.round(2)
    @score
  end
end
