class RenameGroupMemberPermissionsDelete < ActiveRecord::Migration
  def change
    rename_column :group_member_permissions, :delete, :remove
  end
end
