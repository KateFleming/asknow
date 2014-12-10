class AddColumnDefaultPermissionToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :default_permission, :integer
  end
end
