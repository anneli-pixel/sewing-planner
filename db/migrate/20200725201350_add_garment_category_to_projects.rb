class AddGarmentCategoryToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :garment_category, :string
  end
end
