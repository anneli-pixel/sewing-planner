class Project < ApplicationRecord
  include PgSearch::Model

  STATUSES = [ "Draft", "In progress", "Completed"]
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :size, presence: true
  validates :status, inclusion: { in: STATUSES, message: "must be #{Project::STATUSES[0..-2].join(", ")} or #{Project::STATUSES.last}." }
  belongs_to :user
  belongs_to :pattern
  has_many :shopping_items
  has_many :fabrics
  has_one :garment_category, through: :pattern

  delegate :garment_category, to: :pattern
  accepts_nested_attributes_for :fabrics, reject_if: :all_blank, allow_destroy: true

  pg_search_scope :search_by_pattern_title_and_designer, associated_against: { pattern: [:title, :designer] }
  pg_search_scope :search_by_title, against: :title
  pg_search_scope :filter_by_pattern_fabric_type, associated_against: { pattern: :fabric_type }
  pg_search_scope :filter_by_pattern_garment_category, associated_against: {
    garment_category: :name }

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
