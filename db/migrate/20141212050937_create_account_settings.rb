class CreateAccountSettings < ActiveRecord::Migration
  def change
    create_table :account_settings do |t|
      t.boolean :group_email_notifications, :default => true
      t.timestamps
    end
  end
end
