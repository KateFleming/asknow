class AddColumnToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :primary, :boolean
  end
end
