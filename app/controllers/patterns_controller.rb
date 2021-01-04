class PatternsController < ApplicationController

  def index
    @patterns = policy_scope(Pattern).order(garment_category: :asc, title: :asc)
  end

  def new
    @pattern = Pattern.new
    authorize @pattern
  end

  def create
    puts params
    @pattern = Pattern.new(pattern_params)
    authorize @pattern
    @pattern.user = current_user
    if @pattern.save
      redirect_to pattern_path(@pattern), notice: "Pattern successfully created."
    else
      render :new
      puts "Not saved"
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
    authorize @pattern
  end

  def edit
    @pattern = Pattern.find(params[:id])
    authorize @pattern
  end

  def update
    @pattern = Pattern.find(params[:id])
    @pattern.update(pattern_params)
    redirect_to pattern_path(@pattern), notice: "Pattern succesfully edited."
    authorize @pattern
  end

  private

  def pattern_params
    params.require(:pattern).permit(:title, :designer, :fabric_type, :pattern_url, :garment_category, :notes)
  end

end
