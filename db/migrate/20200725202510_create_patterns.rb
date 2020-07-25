class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.string :title
      t.string :designer
      t.string :fabric_type
      t.string :pattern_url
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
