class CreateContentsTable < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :page_content
      t.string :title
      t.integer :user_id, null: false
      t.integer :tweet_id
      t.boolean :seen, deault: false
      t.timestamps
    end
  end
end
