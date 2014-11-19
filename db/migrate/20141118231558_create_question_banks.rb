class CreateQuestionBanks < ActiveRecord::Migration
  def change
    create_table :question_banks do |t|
      t.integer :question_id
      t.references :feed, index: true
      t.timestamps
    end
  end
end
