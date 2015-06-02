class ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = current_user
    @item = @user.items.build(item_params)
    authorize @item
    @item.set_expiration_date
    if @item.save
      flash[:notice] = "New item successfully added to list"
      redirect_to root_path
    else
      flash[:error] = "There was a problem adding the item to your list. Please try again"
      redirect_to root_path
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    authorize @item
    @item.destroy
      
    respond_to do |format|
      format.html do
        if @item.destroyed?
          flash[:notice] = 'The task was deleted successfully.'
        else
          flash[:error] = 'There was a problem deleting the task. Please try again.'
        end
        redirect_to root_path
      end
      
      format.js
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name)
  end
end