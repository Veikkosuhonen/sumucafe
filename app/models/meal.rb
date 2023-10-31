class Meal < ApplicationRecord
  has_many :menu_items
  has_many :ratings
  belongs_to :meal_type

  def score
    @score ||= ratings.average(:score).to_f.round(2)
    @score
  end
end
