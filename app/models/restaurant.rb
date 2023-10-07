class Restaurant < ApplicationRecord
  has_many :menu_items
  belongs_to :location

  validates :name, uniqueness: true

  scope :with_todays_menu, -> {
    includes(:location, menu_items: :meal).where(menu_items: { menu_date: 3.day.from_now...4.day.from_now, is_canceled: false }) }
end
