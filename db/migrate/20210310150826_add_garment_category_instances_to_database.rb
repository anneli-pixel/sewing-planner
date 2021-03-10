class AddGarmentCategoryInstancesToDatabase < ActiveRecord::Migration[6.0]
  def self.up
    puts "Something"
    garment_categories = %w(Pants Pullover/Cardigans Tops Dresses Skirts Underwear Outerwear)
    garment_categories.each do |category|
      GarmentCategory.create(name: category)
    end
  end
end
