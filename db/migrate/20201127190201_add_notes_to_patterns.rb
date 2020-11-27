class AddNotesToPatterns < ActiveRecord::Migration[6.0]
  def change
    add_column :patterns, :notes, :text
  end
end
