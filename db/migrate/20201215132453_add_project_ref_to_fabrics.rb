class AddProjectRefToFabrics < ActiveRecord::Migration[6.0]
  def change
    add_reference :fabrics, :projects, null: false, foreign_key: true
  end
end
