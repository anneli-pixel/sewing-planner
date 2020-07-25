class CreateProjectFabrics < ActiveRecord::Migration[6.0]
  def change
    create_table :project_fabrics do |t|
      t.references :project, null: false, foreign_key: true
      t.references :fabric, null: false, foreign_key: true

      t.timestamps
    end
  end
end
