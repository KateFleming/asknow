class ChangeColumnPermission < ActiveRecord::Migration
  def change
    change_column :groups, :default_permission, :integer, :default => 1
  end
end
