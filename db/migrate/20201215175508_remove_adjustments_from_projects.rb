class RemoveAdjustmentsFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :adjustments, :text
  end
end
