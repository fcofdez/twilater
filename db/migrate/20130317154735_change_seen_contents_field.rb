class ChangeSeenContentsField < ActiveRecord::Migration
  def change
    remove_column :contents, :seen
    add_column :contents, :read, :boolean, default: false
  end
end
