class AddGarmentCategoryRefToPattern < ActiveRecord::Migration[6.0]
  def change
    add_reference :patterns, :garment_category, null: false, foreign_key: true
  end
end
