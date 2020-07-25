class AddGarmentCategoryToPattern < ActiveRecord::Migration[6.0]
  def change
    add_column :patterns, :garment_category, :string
  end
end
