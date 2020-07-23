class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :adjustments
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
