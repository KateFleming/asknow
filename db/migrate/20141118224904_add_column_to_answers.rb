class AddColumnToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :entry, :string
  end
end
