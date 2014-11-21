class SessionController < ApplicationController
  def login
    
  end
  
  def authenticate
    member = Account.find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
    if member
      session[:account_id] = member.id
      session[:account_type] = member.type
      
      # Reset current account
      current_account
      redirect_to trending_path
    else
      @login_errors = "Oops! Something went wrong, please try again!"
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
