class GarmentCategory < ApplicationRecord
  has_many :patterns

  validates :name, presence: true
end
