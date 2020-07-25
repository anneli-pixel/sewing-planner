class Measurement < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :year, presence: true
end
