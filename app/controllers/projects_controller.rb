class ProjectsController < ApplicationController

  def index
    # @projects = Project.all
    @projects = policy_scope(Project)
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end
end
