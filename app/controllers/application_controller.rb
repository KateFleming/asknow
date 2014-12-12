class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper
  
  rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = "Fighting ninja chickens are keeping your from doing that."
      redirect_to :back
  end
end
