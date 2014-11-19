module CommunityHelper
  def current_community
    current_account.community
  end
  def require_community
    redirect_to community_path and return unless current_community
  end
end
