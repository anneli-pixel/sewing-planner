class AddEndDateToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :end_date, :datetime
  end
end
