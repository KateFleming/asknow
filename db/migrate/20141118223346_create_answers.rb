class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :entry
      t.references :account, index: true
      t.references :question, index: true
      t.timestamps
    end
  end
end
