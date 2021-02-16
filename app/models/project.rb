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

  def status_icon_image_path
    if self.status == "Draft"
      "icons/draft.png"
    elsif self.status == "In progress"
      "icons/in_progress.png"
    elsif self.status == "Completed"
      "icons/completed.png"
    end
  end
end
