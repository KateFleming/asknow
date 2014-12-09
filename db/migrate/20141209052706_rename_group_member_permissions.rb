class RenameGroupMemberPermissions < ActiveRecord::Migration
  def change
    rename_column :group_member_permissions, :type, :name
  end
end
