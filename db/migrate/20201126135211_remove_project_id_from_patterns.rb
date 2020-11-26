class RemoveProjectIdFromPatterns < ActiveRecord::Migration[6.0]
  def change
    remove_column :patterns, :project_id, :bigint
  end
end
