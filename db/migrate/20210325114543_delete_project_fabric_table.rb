require_relative "20200725203011_create_project_fabrics"
class DeleteProjectFabricTable < ActiveRecord::Migration[6.0]
  def change
    revert CreateProjectFabrics
  end
end
