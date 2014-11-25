class DeleteCommunityIdFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :community_id
    remove_column :questions, :community_id
  end
end
