class ShoppingItem < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  validates :name, presence: true

  def buy
    self.bought = true
  end
end
