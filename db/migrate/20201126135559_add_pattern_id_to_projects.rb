class AddPatternIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :pattern, foreign_key: true
  end
end
