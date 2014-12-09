class CreateGroupMemberPermissions < ActiveRecord::Migration
  def change
    create_table :group_member_permissions do |t|
      t.string :type
      t.boolean :owner
      t.boolean :read
      t.boolean :write
      t.boolean :invite
      t.boolean :delete
      t.timestamps
    end
  end
end
