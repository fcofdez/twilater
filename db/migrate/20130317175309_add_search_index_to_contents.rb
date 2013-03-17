class AddSearchIndexToContents < ActiveRecord::Migration
  def up
    execute "create index contents_title on contents using gin(to_tsvector('english', title))"
    execute "create index contents_content on contents using gin(to_tsvector('english', page_content))"
  end

  def down
    execute "drop index contents_title"
    execute "drop index contents_content"
  end
end
