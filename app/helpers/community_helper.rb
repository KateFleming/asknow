module CommunityHelper
  def current_community
    current_account.community
  end
  def require_community
    if !current_community
      flash[:notice] = "You need to pick a community first"
      redirect_to community_path and return
    end
  end
end
