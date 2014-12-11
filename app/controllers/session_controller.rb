class SessionController < ApplicationController
  
  def login
    
  end
  
  def authenticate
    member = Account.find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
    if member
      if member.code?
        redirect_to account_not_verified_path(member) and return
      else
        # Login the member
        unless login_account(member) == "redirect"
          redirect_to :trending and return
        end
      end
    else
      flash[:error] = "Oops! Something went wrong, please try again!"
      render 'login'
    end
  end
  
  def logout
    reset_session
  end
  
  private
    def login_params
      params.permit(:email, :password)
    end
end
