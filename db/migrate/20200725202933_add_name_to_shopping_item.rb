class AddNameToShoppingItem < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_items, :name, :string
  end
end
