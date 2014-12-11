class RenameColumnPrivateToPublicGroups < ActiveRecord::Migration
  def change
    rename_column :groups, :private, :public
  end
end
