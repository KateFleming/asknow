class CreateAddAccountIdToAccountSettings < ActiveRecord::Migration
  def change
    add_column :account_settings, :account_id, :integer
  end
end
