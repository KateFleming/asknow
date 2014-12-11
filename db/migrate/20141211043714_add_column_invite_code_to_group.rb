class AddColumnInviteCodeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :invite_code, :string
  end
end
