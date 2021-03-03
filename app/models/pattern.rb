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

  def garment_category_image_path
    GARMENT_CATEGORIES.each do |category|
      if self.garment_category == category
        return "icons/#{category.downcase.gsub("/","_")}.png"
      end
    end
  end
end
