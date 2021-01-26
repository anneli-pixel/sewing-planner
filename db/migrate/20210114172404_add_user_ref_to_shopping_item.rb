class AddUserRefToShoppingItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :shopping_items, :user, null: false, foreign_key: true
  end
end
