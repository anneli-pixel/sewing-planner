class CreateFabrics < ActiveRecord::Migration[6.0]
  def change
    create_table :fabrics do |t|
      t.string :title
      t.string :fabric_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
