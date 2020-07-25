class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.integer :bust
      t.integer :waist
      t.integer :hip
      t.integer :year
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
