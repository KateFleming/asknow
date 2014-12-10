class AddOwnerColumnToGroupMember < ActiveRecord::Migration
  def change
    add_column :group_members, :owner, :boolean
  end
end
