class Pattern < ApplicationRecord
  include PgSearch::Model

  FABRIC_TYPES = %w(Knit Woven)
  has_many :projects
  belongs_to :garment_category
  belongs_to :user
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :designer, presence: true
  validates :fabric_type, presence: true, inclusion: { in: FABRIC_TYPES, message: "must be #{FABRIC_TYPES[0..-2].join(", ")} or #{FABRIC_TYPES.last}."  }

  pg_search_scope :search_by_title_and_designer, against: [:title, :designer]
  pg_search_scope :filter_by_fabric_type, against: :fabric_type
  pg_search_scope :filter_by_garment_category, associated_against: {
    garment_category: :name }

end
