module FormHelper
  def setup_project(project)
    project.fabrics.empty? ? 3.times { project.fabrics.new } : (3 - project.fabrics.length).times { project.fabrics.new }
    project
  end
end
