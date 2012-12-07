class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :url
      t.integer :id
      t.integer :commentCount
      t.integer :points
      t.string :postedAgo
      t.string :postedBy

      t.timestamps
    end
    add_index :items, :points
  end
end
