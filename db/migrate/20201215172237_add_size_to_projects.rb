class AddSizeToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :size, :string
  end
end
