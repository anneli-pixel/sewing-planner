class ShoppingItemsController < ApplicationController
  def new
    @shopping_item = ShoppingItem.new
    authorize @shopping_item
  end

  def create

  end
  def index
  end
end
