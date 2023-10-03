class Restaurant < ApplicationRecord
  has_many :menu_items

  scope :with_todays_menu, -> { includes(menu_items: :meal).where(menu_items: { menu_date: Date.current...1.day.from_now }) }
end
