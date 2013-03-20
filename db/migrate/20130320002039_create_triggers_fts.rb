class CreateTriggersFts < ActiveRecord::Migration
  def up
    execute "ALTER TABLE contents ADD COLUMN tsv tsvector"
    execute <<-QUERY
                  UPDATE contents SET tsv = (to_tsvector('english', coalesce("contents"."title"::text, '')) || 
                                             to_tsvector('english', coalesce("contents"."page_content"::text, '')));
    QUERY

    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
                                            ON users FOR EACH ROW EXECUTE PROCEDURE
                                            tsvector_update_trigger(tsv, 'pg_catalog.english', title, page_content);"
  end
  def down
    execute "drop trigger tsvectorupdate on contents"
    execute "alter table contents drop column tsv"
  end
end
