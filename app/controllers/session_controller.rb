class SessionController < ApplicationController
  
  def login
    
  end
  
  def authenticate
    @account = Account.find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
    if @account
      if @account.code?
        redirect_to account_not_verified_path(@account) and return
      else
        # Login the member
        unless login_account(@account) == "redirect"
          redirect_to :trending and return
        end
      end
    else
      flash.now[:error] = "That didn't work. Try again."
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
