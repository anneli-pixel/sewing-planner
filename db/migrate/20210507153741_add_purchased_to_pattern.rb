class AddPurchasedToPattern < ActiveRecord::Migration[6.0]
  def change
    add_column :patterns, :purchased, :boolean, default: false
  end
end
