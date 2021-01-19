class ShoppingItemsController < ApplicationController
  def new
    @shopping_item = ShoppingItem.new
    @shopping_item.project_id = params[:project_id]
    authorize @shopping_item
  end

  def create
    @shopping_item = ShoppingItem.new(shopping_item_params)
    authorize @shopping_item
    @shopping_item.user = current_user

    if shopping_item_params[:project_id].empty?
      @shopping_item.project_id = nil
    else
      @shopping_item.project_id = shopping_item_params[:project_id]
    end

    if @shopping_item.save
      redirect_to shopping_items_path, notice: "Shopping item successfully created."
    else
      render :new
    end
  end

  def index
    @shopping_items = policy_scope(ShoppingItem).order(bought: :asc, name: :asc)
  end

  def toggle_bought
    @shopping_item = ShoppingItem.find(params[:id])
    authorize @shopping_item
    @shopping_item.toggle(:bought).save
    redirect_to shopping_items_path notice: "Something happened."
  end

  def shopping_item_params
    params.require(:shopping_item).permit(:name, :project_id)
  end
end
