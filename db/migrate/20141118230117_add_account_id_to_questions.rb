class AddAccountIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :account_id, :integer
  end
end
