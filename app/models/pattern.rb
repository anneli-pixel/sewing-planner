class Pattern < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  validates :designer, presence: true
  validates :fabric_type, presence: true, inclusion: { in: %w(Knit Woven), message: "must be Knit or Woven." }
  validates :garment_category, inclusion: { in: ["Pants", "Tops", "Dresses", "Skirts", "Underwear", "Outerwear"] }
end
