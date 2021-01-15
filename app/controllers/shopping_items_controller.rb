class ShoppingItemsController < ApplicationController
  def new
    @shopping_item = ShoppingItem.new
    authorize @shopping_item
  end

  def create
    @shopping_item = ShoppingItem.new(shopping_item_params)
    authorize @shopping_item
    @shopping_item.user = current_user
    shopping_item_params[:project_id].empty? ? @shopping_item.project_id = nil : @shopping_item.project_id = shopping_item_params[:project_id]
    if @shopping_item.save
      redirect_to shopping_items_index_path, notice: "Shopping item successfully created."
    else
      render :new
    end
  end

  def index
    @shopping_items = policy_scope(ShoppingItem)
  end

  def shopping_item_params
    params.require(:shopping_item).permit(:name, :project_id)
  end
end
