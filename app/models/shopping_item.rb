class ShoppingItem < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  validates :name, presence: true

  def buy
    self.bought = true
  end

  def bought_status_image_path
    self.bought ? "icons/001-check.png" : "icons/002-circle-outline.png"
  end
end
