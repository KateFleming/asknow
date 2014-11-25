class AccountController < ApplicationController
  before_filter :require_logged_in, :require_community
  def panel
    @account = current_account
    @questions = Question.where(account: @account).all.reverse
    
    authorize! :read, @account
  end
end