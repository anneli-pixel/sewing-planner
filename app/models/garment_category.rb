class GarmentCategory < ApplicationRecord
  has_many :patterns

  validates :name, presence: true

  def image
    ActionController::Base.helpers.image_tag self.image_path, class: "garment-category-icon", id: self.name
  end

  def image_path
    "icons/#{self.name.downcase.gsub("/","_").gsub(" ", "_")}.png"
  end

  def normalised_name
    self.name.downcase.gsub("/","_").gsub(" ", "_")
  end

  def self.sorted_all
    GarmentCategory.all.sort_by do |category|
      category.name
    end
  end

end
