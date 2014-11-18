class MemberController < ApplicationController
  def new
    @member = Member.new
  end
  
  def create

    # Create a new member
    @member = Member.new(member_params)
    
    if @member.save
      redirect_to action: 'success'
    else
      render :new
    end
  end
  
  def success

  end
  
  private
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation)
    end
end
