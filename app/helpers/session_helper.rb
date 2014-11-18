module SessionHelper
  
  def require_logged_in
    redirect_to session_login_path and return if current_account.guest?
  end
  
  def current_account
    if session[:account_id]
      @current_account = Account.find(session[:account_id])
    else
      @current_account = Guest.create
      session[:account_id] = @current_account.id
    end
    @current_account
  end
end
