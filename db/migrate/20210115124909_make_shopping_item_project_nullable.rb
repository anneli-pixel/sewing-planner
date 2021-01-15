class MakeShoppingItemProjectNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :shopping_items, :project_id, true
  end
end
