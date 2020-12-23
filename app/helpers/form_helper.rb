module FormHelper
  def setup_project(project)
    project.fabrics ||= Fabric.new
    3.times { project.fabrics.new }
    project
  end
end
