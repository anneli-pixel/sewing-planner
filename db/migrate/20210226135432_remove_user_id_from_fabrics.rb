class RemoveUserIdFromFabrics < ActiveRecord::Migration[6.0]
  def change
    remove_column :fabrics, :user_id, :bigint
  end
end
