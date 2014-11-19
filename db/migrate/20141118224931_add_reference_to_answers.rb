class AddReferenceToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :account_id, :integer
  end
end
