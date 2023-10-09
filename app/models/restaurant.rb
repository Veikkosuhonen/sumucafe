class Restaurant < ApplicationRecord
  has_many :menu_items
  belongs_to :location

  validates :name, uniqueness: true

  scope :with_todays_menu, -> {
    with_days_menu(Date.now)
  }

  scope :with_days_menu, ->(date) {
    includes(:location, menu_items: { meal: :meal_type })
      .where(menu_items: { menu_date: date.beginning_of_day...date.tomorrow.beginning_of_day, is_canceled: false })
  }
end
