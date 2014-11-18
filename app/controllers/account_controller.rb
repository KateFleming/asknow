class AccountController < ApplicationController
  before_filter :require_logged_in, :require_community
  def panel
    
  end
end