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
  
  # You just got invited to a group
  def invite
    invite_code = params[:code]
    
    # Grab the group
    @group = Group.find_by(invite_code: invite_code)
    
    # Check if that group exists
    if @group
      # If they're a guest, prompt them to sign up or login
      if current_account.guest?
        session[:routes] = { "login" => group_invite_path(invite_code) }
        flash[:notice] = "To join #{ @group.name }, login or sign up."
        redirect_to :session_login
      else
        authorize! :join, @group

        # Create a new group member
        group_member = GroupMember.new({
          account: current_account,
          group: @group,
          group_member_permission: @group.default_member_permission
        })

        # Try saving the member
        if group_member.save
          flash[:notice] = "Welcome to the group, #{current_account.display_name}"
          redirect_to group_show_path(@group)
        else
          flash[:error] = group_member.errors.full_messages.join(",")
          redirect_to :trending
        end
      end
    else
      flash[:error] = "That invite code is bad, bummer dude."
      redirect_to :trending
    end
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :private, :default_permission)
  end
end
