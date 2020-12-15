class Project < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: ["Draft", "In progress", "Completed"] }
  #validates :garment_category, inclusion: { in: ["Pants", "Tops", "Dresses", "Skirts", "Underwear", "Outerwear"] }
  belongs_to :user
  belongs_to :pattern
  has_many :shopping_items
  has_many :fabrics
  has_many :project_fabrics
  has_many :fabrics, through: :project_fabrics

  def start_date
    # self.start_date = self.created_at
    # start_date = date when status is changed from 'Draft' to 'In progress'
  end

  def end_date
    # end_date = date when status is changed to Completed
  end
end
