class RemoveColumnGarmentCategoryFromPatterns < ActiveRecord::Migration[6.0]
  def change
    remove_column :patterns, :garment_category, :string
  end
end
