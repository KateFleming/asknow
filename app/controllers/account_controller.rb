class AccountController < ApplicationController
  def panel
    @account = current_account
    @questions = Question.where(account: @account).all.reverse
    authorize! :read, @account
  end
  
  # Verify an account
  def verify
    code = params[:code]
    @account = Account.find_by(code: code)
    
    # Was that code valid?
    if @account
      # Set the code to empty
      @account.code = ""
      if @account.save
        
        # Login the user
        session[:account_id] = @account.id
        session[:account_type] = @account.type
      
        # Reset current account
        current_account
        
        flash[:notice] = "Your account has been verified. And we love you for it."
        redirect_to :trending
      else
        flash[:errror] = @account.errors.full_messages.join(",")
      end
    else
      flash[:error] = "That code wasn't found. Is your account already verified?"
      redirect_to :session_login
    end
  end
  
  # Account is not verified
  def not_verified
    account_id = params[:id]
    @account = Account.find(account_id)
  end
  
  # Resend verification code
  def resend_code
    @account = Account.find(params[:account_id])
    if @account.member? || @account.admin?
      TransactionMailer.verify(@account).deliver
      flash[:notice] = "You're email is on its way."
      redirect_to :back and return
    else
      flash[:error] = "Boo. You're not a member yet."
      redirect_to :back and return
    end
  end
end