class ProjectsController < ApplicationController

  def index
    @projects = policy_scope(Project)
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def new
    @project = Project.new
    @project.pattern_id = params[:pattern_id]
    @fabric = Fabric.new(project_id: @project.id)
    authorize @project
    authorize @fabric
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.fabrics.each do |fabric|
      fabric.user = current_user
    end
    authorize @project

    if @project.save
      redirect_to project_path(@project), notice: "Project successfully created."
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :size, :pattern_id, fabrics_attributes: [:title])
  end
end
