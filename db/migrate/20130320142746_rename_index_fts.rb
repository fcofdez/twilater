class RenameIndexFts < ActiveRecord::Migration
  def up
    execute "drop index contents_title"
    execute "drop index contents_content"
    execute "create index idx_contents on contents using gin(tsv)"
  end

  def down
    execute "drop index idx_contents"
  end
end
