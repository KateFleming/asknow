module CommunityHelper
  def require_community
    redirect_to community_path and return unless current_account.community
  end
end
