class RenameContentsColums < ActiveRecord::Migration
  def change
    rename_column :contents, :user_id, :identity_id
  end
end
