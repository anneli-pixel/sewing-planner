class GarmentCategory < ApplicationRecord
  has_many :patterns

  validates :name, presence: true

  def image
    ActionController::Base.helpers.image_tag self.image_path, class: "garment-category-icon", id: self.name
  end

  def image_flip_card(css_class = "")
    flip_card_front = ActionController::Base.helpers.image_tag self.image_path, class: "garment-category-icon flip-card-front", id: self.name
    flip_card_back = "<div class='garment-category-name flip-card-back small-text'> #{self.name} </div>".html_safe
    flip_card = flip_card_front + flip_card_back
  end

  def image_path
    "icons/#{self.name.downcase.gsub("/","_").gsub(" ", "_")}.png"
  end

  def normalised_name
    self.name.downcase.gsub("/","_").gsub(" ", "_")
  end

  def self.sorted_all
    all_categories = GarmentCategory.all.sort_by do |category|
      category.name
    end
    last_category = all_categories.find { |category| category.name == "Miscellaneous"}
    all_categories.partition { |v| v != last_category }.flatten
  end

end
