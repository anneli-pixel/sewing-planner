class Project < ApplicationRecord
  STATUSES = [ "Draft", "In progress", "Completed"]
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :size, presence: true
  validates :status, inclusion: { in: STATUSES, message: "must be #{Project::STATUSES[0..-2].join(", ")} or #{Project::STATUSES.last}." }
  belongs_to :user
  belongs_to :pattern
  has_many :shopping_items
  has_many :fabrics

  delegate :garment_category, to: :pattern
  accepts_nested_attributes_for :fabrics, reject_if: :all_blank

  def start_date
    # self.start_date = self.created_at
    # start_date = date when status is changed from 'Draft' to 'In progress'
  end

  def end_date
    # end_date = date when status is changed to Completed
  end
end
