class RemoveFalseProjectsIdFromFabrics < ActiveRecord::Migration[6.0]
  def change
    remove_reference :fabrics, :projects, null: false, foreign_key: true
  end
end
