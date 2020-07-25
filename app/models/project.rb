class Project < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: ["Draft", "In progress", "Completed"] }
  validates :garment_category, inclusion: { in: ["Pants", "Tops", "Dresses", "Skirts", "Underwear", "Outerwear"] }
  belongs_to :user
  has_many :patterns
  has_many :shopping_items
  has_many :project_fabrics
  has_many :fabrics, through: :project_fabrics
end
