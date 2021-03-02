class ProjectsController < ApplicationController
  before_action :save_referrer, except: [:create]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
    @project.pattern_id = params[:pattern_id]
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize @project

    if @project.save
      redirect_to project_path(@project), notice: "Project successfully created."
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project succesfully edited."
    else
      redirect_to project_path(@project), notice: "Something went wrong. Please try again."
    end
    authorize @project
  end

  def change_status
    @project = Project.find(params[:id])
    authorize @project
    index = Project::STATUSES.index(@project.status)
    @project.status = Project::STATUSES[(index+1)%Project::STATUSES.size]
    if @project.save
      render :show
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :size, :pattern_id, fabrics_attributes: [:title, :id, :_destroy])
  end
end
