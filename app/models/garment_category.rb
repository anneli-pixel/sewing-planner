class GarmentCategory < ApplicationRecord
  has_many :patterns

  validates :name, presence: true

  def image
    ActionController::Base.helpers.image_tag self.image_path, class: "garment-category-icon"
  end

  def image_path
    "icons/#{self.name.downcase.gsub("/","_")}.png"
  end

  def normalised_name
    self.name.downcase.gsub("/","_")
  end


end
