class RemoveGarmentCategoryFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :garment_category, :string
  end
end
