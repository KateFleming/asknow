class LolLol < ActiveRecord::Migration
  def change
    change_column :questions, :group_id, :integer
  end
end
