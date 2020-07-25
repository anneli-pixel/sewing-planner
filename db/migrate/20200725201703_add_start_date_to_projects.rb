class AddStartDateToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :start_date, :datetime
  end
end
