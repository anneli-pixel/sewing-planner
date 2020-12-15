class AddCorrectProjectRefToFabrics < ActiveRecord::Migration[6.0]
  def change
    add_reference :fabrics, :project, null: false, foreign_key: true
  end
end
