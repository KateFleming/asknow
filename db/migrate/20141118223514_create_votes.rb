class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :answer, index: true
      t.references :account, index: true
      t.timestamps
    end
  end
end
