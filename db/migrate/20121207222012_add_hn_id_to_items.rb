class AddHnIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :HN_id, :integer
  end
end
