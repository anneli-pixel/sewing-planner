class AddColumnToShoppingItem < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_items, :bought, :boolean, default: false
  end
end
