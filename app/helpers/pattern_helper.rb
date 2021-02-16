include ActionView::Helpers::AssetTagHelper

module PatternHelper

  class GarmentCategory
    attr_reader :name

    def initialize(name)
      @path = PatternHelper.path_for(name)
      @name = name
    end

    def image
      ActionController::Base.helpers.image_tag @path, class: "garment-category-icon"
    end

  end

  def self.path_for(garment_category)
    return "icons/#{garment_category.downcase.gsub("/","_")}.png"
  end

  def garment_category_for(pattern)

  end

  def self.garment_categories
    Pattern::GARMENT_CATEGORIES.map { |category| GarmentCategory.new(category) }
  end


end
