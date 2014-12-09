class AddPowersToGroupMemberPermissions < ActiveRecord::Migration
  def change
    add_column :group_member_permissions, :powers, :string
  end
end
