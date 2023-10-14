class Restaurant < ApplicationRecord
  has_many :menu_items, -> { where(is_canceled: false) }
  belongs_to :location

  validates :name, uniqueness: true

  scope :with_todays_menu, -> {
    with_days_menu(Date.today)
  }

  scope :with_days_menu, ->(date) {
    includes(menu_items: { meal: :meal_type })
      .where(menu_items: { menu_date: date, is_canceled: false })
  }

  scope :closed_on, ->(date) {
    left_outer_joins("
        LEFT OUTER JOIN menu_items ON menu_items.restaurant_id = restaurants.id
        AND menu_items.menu_date = '#{date}'
    ").missing(:menu_items).distinct
  }

  def menu_items_on(date)
    @menu_items_by_day ||= {} # Make sure instance var is initialized
    @menu_items_by_day[date] ||= menu_items.on_date(date) # Memoize
  end

  def open_on(date)
    menu_items_on(date).any?
  end

end
