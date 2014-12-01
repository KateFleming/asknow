class ChangeKeywordToTag < ActiveRecord::Migration
  def change
    rename_column :questions, :keywords, :tags
  end
end
