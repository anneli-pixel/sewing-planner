class ProjectsController < ApplicationController

  def index
    # @projects = Project.all
    @projects = policy_scope(Project)
  end

end
