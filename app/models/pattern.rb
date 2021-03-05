class Pattern < ApplicationRecord
  include PgSearch::Model

  FABRIC_TYPES = %w(Knit Woven)
  GARMENT_CATEGORIES = %w(Pants Pullover/Cardigans Tops Dresses Skirts Underwear Outerwear)
  has_many :projects
  belongs_to :user
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :designer, presence: true
  validates :fabric_type, presence: true, inclusion: { in: FABRIC_TYPES, message: "must be #{FABRIC_TYPES[0..-2].join(", ")} or #{FABRIC_TYPES.last}."  }
  validates :garment_category, inclusion: { in: GARMENT_CATEGORIES, message: "must be #{GARMENT_CATEGORIES[0..-2].join(", ")} or #{GARMENT_CATEGORIES.last}." }

  pg_search_scope :search_by_title_and_designer, against: [:title, :designer]
  pg_search_scope :filter_by_fabric_type, against: :fabric_type
  pg_search_scope :filter_by_garment_category, against: :garment_category

  def garment_category_image_path
    "icons/#{self.garment_category.downcase.gsub("/","_")}.png"
  end
end
