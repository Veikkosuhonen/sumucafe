class Location < ApplicationRecord
  has_many :restaurants

  validates :name, uniqueness: true
end
