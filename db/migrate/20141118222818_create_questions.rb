class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :entry
      t.string :keywords
      t.references :community, index: true
      
      t.timestamps
    end
  end
end
