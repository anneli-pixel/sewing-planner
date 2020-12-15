class RemoveFabricTypeFromFabrics < ActiveRecord::Migration[6.0]
  def change
    remove_column :fabrics, :fabric_type, :string
  end
end
