class RemovePublicColumnFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :public
  end
end
