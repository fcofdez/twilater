module PostgresqlFTS

  def self.included(base)

    base.class_eval do
      class_attribute :columns_searchables
    end

    base.extend(Configuration)
    base.extend(Searchable)
    base.extend(Ranking)
  end

  module Configuration

    def searchable(&columns_definition)
      self.columns_searchables ||= []
      columns_definition.call
    end

    def column field
      self.columns_searchables << field
    end

  end

  module Ranking
    def rank_fields(query)
      ranks = []
      self.columns_searchables.each do |field|
        ranks << "ts_rank(to_tsvector(#{field}), plainto_tsquery(#{sanitize(query)}))"
      end
      ranks.join(' + ')
    end
  end

  module Searchable
    def search(query = nil)

      return all if query.nil?
      fields_query = []

      columns_searchables.each do |field|
        fields_query << "tsv @@ plainto_tsquery('english', :q::text)"
      end

      where(fields_query.join(" OR "), q: query).order("#{rank_fields(query)} desc")
    end
  end

end
