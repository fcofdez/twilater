class TriggersCorrection < ActiveRecord::Migration
  def up
    execute "drop trigger tsvectorupdate on users"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
                                            ON contents FOR EACH ROW EXECUTE PROCEDURE
                                            tsvector_update_trigger(tsv, 'pg_catalog.english', title, page_content);"
  end

  def down
    execute "drop trigger tsvectorupdate on contents"
  end
end
