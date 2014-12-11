class ChangeColumnGroup2 < ActiveRecord::Migration
  def change
    change_column :questions, :group_id, :integer, :default => 0
  end
end
