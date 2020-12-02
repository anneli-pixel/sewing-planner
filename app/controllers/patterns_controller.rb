class PatternsController < ApplicationController

  def new
    @pattern = Pattern.new
    authorize @pattern
  end

  def create
    @pattern = Pattern.new(pattern_params)
    authorize @pattern
    @pattern.user = current_user
    if @pattern.save
      redirect to pattern_path
    else
      puts "Not saved"
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
    authorize @pattern
  end
end
