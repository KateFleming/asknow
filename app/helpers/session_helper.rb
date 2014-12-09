module SessionHelper
  def require_logged_in
    redirect_to session_login_path and return if current_account.guest?
  end
  
  # If a member hasn't verified their account, make them do that
  def require_verified_account
    if current_account.code
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
  
  # For CanCan
  def current_user
    current_account
  end
end
