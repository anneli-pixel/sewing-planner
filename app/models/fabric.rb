class Fabric < ApplicationRecord
  belongs_to :user
  has_many :project_fabrics
  validates :title, presence: true
  validates :fabric_type, presence: true, inclusion: { in: %w(Knit Woven), message: "must be Knit or Woven." }
end
