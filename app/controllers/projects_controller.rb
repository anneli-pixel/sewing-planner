class ProjectsController < ApplicationController
  before_action :save_referrer, except: [:create]

  def index
    if params[:query].present?
      pattern_search = policy_scope(Project).search_by_pattern_title_and_designer("#{params[:query]}")
      project_title_search = policy_scope(Project).search_by_title("#{params[:query]}")
      @projects = Set.new(pattern_search.to_a)+project_title_search.to_a
    elsif params[:fabric_type_filter].present?
      @projects = policy_scope(Project).filter_by_pattern_fabric_type("#{params[:fabric_type_filter]}")
    elsif params[:garment_category_filter].present?
      @projects = policy_scope(Project).filter_by_pattern_garment_category("#{params[:garment_category_filter]}")
    else
      @projects = policy_scope(Project)
    end


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
      #render :show
      redirect_to project_path(@project)+"##{@project.normalised_status}"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :size, :pattern_id, fabrics_attributes: [:title, :id, :_destroy])
  end

end
