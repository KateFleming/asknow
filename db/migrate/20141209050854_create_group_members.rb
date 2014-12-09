class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :account_id
      t.integer :group_member_permission
      t.timestamps
    end
  end
end