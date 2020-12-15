class Fabric < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :project_fabrics
  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }
  #validates :fabric_type, presence: true, inclusion: { in: %w(Knit Woven), message: "must be Knit or Woven." }
end
