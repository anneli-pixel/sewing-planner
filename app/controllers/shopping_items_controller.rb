class ShoppingItemsController < ApplicationController
  before_action :save_referrer, except: [:create]

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

    if @shopping_item.save && @shopping_item.project_id.nil?
      redirect_to shopping_items_path + @shopping_item.anchor
    elsif @shopping_item.save
      if session[:referrer].nil?
        redirect_to shopping_items_path
      else
        redirect_to session[:referrer] + @shopping_item.anchor
      end
    else
      render :new
    end
  end

  def index
    @shopping_items = policy_scope(ShoppingItem).order(bought: :asc, name: :asc)
    @bought_items = policy_scope(ShoppingItem).where(bought: true).order(bought: :asc, name: :asc)
    @to_buy_items = policy_scope(ShoppingItem).where(bought: false).order(bought: :asc, name: :asc)
  end

  def toggle_bought
    @shopping_item = ShoppingItem.find(params[:id])
    authorize @shopping_item
    @shopping_item.toggle(:bought).save
    redirect_to request.referer + @shopping_item.anchor
  end

  def destroy
    @shopping_item = ShoppingItem.find(params[:id])
    authorize @shopping_item
    @shopping_item.destroy
    redirect_to shopping_items_path
  end

  private

  def shopping_item_params
    params.require(:shopping_item).permit(:name, :project_id)
  end
end
