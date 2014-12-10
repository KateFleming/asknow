class GroupController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    
    if @group.save
      flash[:notice] = "Hey look at you! You started a group."
      redirect_to group_show_path(@group.id)
    else
      render 'new'
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :private, :default_permission)
  end
end
