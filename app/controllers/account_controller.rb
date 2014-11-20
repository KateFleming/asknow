class AccountController < ApplicationController
  before_filter :require_logged_in, :require_community
  def panel
    @questions = Question.where(account: current_account).all.reverse
  end
end