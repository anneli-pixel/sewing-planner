class Pattern < ApplicationRecord
  before_destroy :purge_project_images
  include PgSearch::Model
  attr_accessor :delete_photo

  FABRIC_TYPES = %w(Knit Woven)
  has_many :projects, dependent: :destroy
  belongs_to :garment_category
  belongs_to :user
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :designer, presence: true
  validates :fabric_type, presence: true, inclusion: { in: FABRIC_TYPES, message: "must be #{FABRIC_TYPES[0..-2].join(", ")} or #{FABRIC_TYPES.last}."  }
  has_one_attached :photo, dependent: :destroy


  pg_search_scope :search_by_title_and_designer, against: [:title, :designer]
  pg_search_scope :filter_by_fabric_type, against: :fabric_type
  pg_search_scope :filter_by_garment_category, associated_against: {
    garment_category: :name }

  def custom_image_tag
    if self.photo.attached?
      image_tag = ActionController::Base.helpers.cl_image_tag self.photo.key
      image_tag.gsub!("<img src=", "").gsub(" />", "")
    else
      "no_image"
    end
  end

  def full_pattern_url
    url = self.pattern_url
    if url.start_with?("https", "http")
      url
    else
      url = "http://" + url
    end
    url
  end

  def shopping_items
    projects = self.projects
    shopping_items = []
    projects.each do |project|
      shopping_items << project.shopping_items
    end
    shopping_items.flatten
  end

  private

  def purge_project_images
    self.projects.each do |project|
      unless !project.photo.attached?
        project.photo.purge
      end
    end
  end
end
