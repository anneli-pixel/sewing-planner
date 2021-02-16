class PatternsController < ApplicationController

  def index
    @patterns = policy_scope(Pattern).order(garment_category: :asc, title: :asc)
  end

  def new
    @pattern = Pattern.new
    authorize @pattern
  end

  def create
    @pattern = Pattern.new(pattern_params)
    authorize @pattern
    @pattern.user = current_user
    if @pattern.save
      redirect_to patterns_path+"##{@pattern.id.to_s}", notice: "Pattern successfully created."
    else
      render :new
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
    authorize @pattern

    respond_to do |format|
       format.js
     end

  end

  def edit
    @pattern = Pattern.find(params[:id])
    authorize @pattern
  end

  def update
    @pattern = Pattern.find(params[:id])
    if @pattern.update(pattern_params)
      redirect_to patterns_path(anchor: @pattern.id), notice: "Pattern succesfully edited."
    else
      redirect_to patterns_path(anchor: @pattern.id), notice: "Something went wrong. Please try again."
    end
    authorize @pattern
  end

  private

  def pattern_params
    params.require(:pattern).permit(:title, :designer, :fabric_type, :pattern_url, :garment_category, :notes)
  end

end
