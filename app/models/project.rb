class Project < ApplicationRecord
  include PgSearch::Model
  attr_accessor :delete_photo

  STATUSES = [ "Draft", "In progress", "Completed"]
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :size, presence: true
  validates :status, inclusion: { in: STATUSES, message: "must be #{Project::STATUSES[0..-2].join(", ")} or #{Project::STATUSES.last}." }
  belongs_to :user
  belongs_to :pattern
  has_many :shopping_items, dependent: :destroy
  has_many :fabrics, dependent: :destroy
  has_one :garment_category, through: :pattern
  has_one_attached :photo, dependent: :destroy

  delegate :garment_category, to: :pattern
  accepts_nested_attributes_for :fabrics, reject_if: :all_blank, allow_destroy: true

  pg_search_scope :search_by_pattern_title_and_designer, associated_against: { pattern: [:title, :designer] }
  pg_search_scope :search_by_title, against: :title
  pg_search_scope :filter_by_pattern_fabric_type, associated_against: { pattern: :fabric_type }
  pg_search_scope :filter_by_pattern_garment_category, associated_against: {
    garment_category: :name }

  def normalised_status
    self.status.downcase.gsub(" ", "-")
  end
end
