class MealType < ApplicationRecord
  has_many :meals
  validates :name, presence: true, uniqueness: true

  def price_for(category)
    category_price = price[category]
    if category_price.nil?
      return nil
    end

    float_price = category_price.to_f
    unless float_price > 0
      return nil
    end

    float_price
  end

  def color_style
    if name == "Vegaani"
      return "#72c47a"
    elsif name == "Makeasti"
      return "#a779c7"
    elsif name == "Päivän lounas"
      return "#ccb25e"
    elsif name == "Päivän erikoinen"
      return "#a6cf55"
    elsif name == "Lisuke"
      return "#87b06d"
    end
    "gray"
  end
end
