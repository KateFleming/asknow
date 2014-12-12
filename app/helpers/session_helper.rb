module SessionHelper
  def require_logged_in
    redirect_to session_login_path and return if current_account.guest?
  end
  
  # If a member hasn't verified their account, make them do that
  def require_verified_account
    if current_account.code.present?
      redirect_to account_not_verified_path(current_account) and return
    end
  end
  
  def current_account
    if session[:account_id]
      @current_account = Account.find(session[:account_id])
    else
      @current_account = Account.create(account_type: "guest")
      session[:account_id] = @current_account.id
    end
    @current_account
  end
  
  def login_account(account)
    # Set session variables
    session[:account_id] = account.id
    session[:account_type] = account.type
    
    # Reset current account
    current_account
    
    # Check for any login-related redirects
    if check_persistent_routes("login")
      return "redirect"
    end
  end
  
  # Check for any persistent routes
  def check_persistent_routes(dest)
    if defined? session[:routes][dest]
      fly_me_there = session[:routes][dest]
      if fly_me_there
        session[:routes].delete [dest]
        redirect_to fly_me_there and return true
      end
    end
  end
  
  # For CanCan
  def current_user
    current_account
  end
end
