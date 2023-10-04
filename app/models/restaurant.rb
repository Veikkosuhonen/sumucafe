class Restaurant < ApplicationRecord
  has_many :menu_items
  belongs_to :location

  validates :name, uniqueness: true

  scope :with_todays_menu, -> {
    includes(:location, menu_items: :meal).where(menu_items: { menu_date: Date.current...1.day.from_now }) }
end
