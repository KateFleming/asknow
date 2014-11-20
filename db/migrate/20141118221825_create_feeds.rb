class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :tag
      t.string :name
      t.boolean :private
      t.references :account, index: true
      t.timestamps
    end
  end
end
