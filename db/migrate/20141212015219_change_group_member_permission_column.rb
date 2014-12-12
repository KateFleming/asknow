class ChangeGroupMemberPermissionColumn < ActiveRecord::Migration
  def change
    rename_column :group_members, :group_member_permission, :group_member_permission_id
  end
end
