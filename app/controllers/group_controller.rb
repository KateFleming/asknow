class GroupController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    # Add group info
    @group = Group.new(group_params)
    
    # Save the group
    if @group.save
      # Add the user a member
      group_member = GroupMember.new({
        group: @group,
        account: current_account,
        owner: true,
        group_member_permission: GroupMemberPermission.powerizer
      })
      
      if group_member.save
        flash[:notice] = "Hey look at you! You started a group."
        redirect_to group_show_path(@group.id)
      else
        flash[:error] = "Bummer, we had a problem saving the group"
        logger.error(group_member.inspect)
        render 'new'
      end
    else
      render 'new'
    end
  end
  
  def show
    @group = Group.find(params[:id])
    
    @question = Question.new
    @questions = @group.questions
    @questions = @questions.order("created_at desc").paginate({
      page: params[:page]
    })
    
    render layout: "full-width"
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :private, :default_permission)
  end
end
