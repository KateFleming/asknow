class MemberController < ApplicationController
  def new
    @member = Account.new
  end
  
  def create
    # Create a new member
    if current_account.member?
      redirect_to account_panel_path
    elsif current_account.guest?
      # If they're a guest, convert to a member
      @member = current_account
      @member.account_type = "member"
      @member.assign_attributes(member_params)
      
      # Create verify email code
      @member.generate_code
      
      # Save the new member
      if @member.save
        TransactionMailer.verify(@member).deliver
        redirect_to account_not_verified_path(@member)
      else
        render :new
      end
    end
  end
  
  def success

  end
  
  private
    def member_params
      params.require(:account).permit(:name, :email, :password, :password_confirmation)
    end
end
