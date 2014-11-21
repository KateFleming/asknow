class CommunityController < ApplicationController
  def index
    @communities = Community.all
  end
  def pick
    @account = current_account
    
    if @account.update_attribute(:community_id, params[:id])
      redirect_to trending_path
    else
      @page_error = "There was an error choosing a community"
      logger.debug("Error choosing community")
      logger.debug(@account.errors)
      render :index
    end
  end
end
