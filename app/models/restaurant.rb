class Restaurant < ApplicationRecord
  has_many :menu_items
  belongs_to :location

  validates :name, uniqueness: true

  scope :with_todays_menu, -> {
    with_days_menu(Date.today)
  }

  scope :with_days_menu, ->(date) {
    between(date.beginning_of_day, (date + 1.day).beginning_of_day)
  }


  scope :between, ->(start_date, end_date) {
    includes(menu_items: { meal: :meal_type })
      .where(menu_items: { menu_date: start_date...end_date, is_canceled: false })
  }
end
