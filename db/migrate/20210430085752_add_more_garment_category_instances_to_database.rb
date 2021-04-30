class AddMoreGarmentCategoryInstancesToDatabase < ActiveRecord::Migration[6.0]
  def change
    garment_categories = ["Cardigans", "Onesies", "Accessories", "Home Decor", "Miscellaneous", "Sleepwear"]
    garment_categories.each do |category|
      GarmentCategory.create(name: category)
    end
  end
end
