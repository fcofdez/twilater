class AddCountColumnForContentsInUser < ActiveRecord::Migration
  def change
    add_column :users, :contents_count, :integer
  end
end
