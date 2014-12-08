class AddAccountCode < ActiveRecord::Migration
  def change
    add_column :accounts, :code, :string
  end
end
