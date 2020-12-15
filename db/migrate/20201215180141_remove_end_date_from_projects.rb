class RemoveEndDateFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :end_date, :datetime
  end
end
