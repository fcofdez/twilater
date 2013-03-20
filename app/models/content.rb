class Content < ActiveRecord::Base
  attr_accessible :title, :page_content, :user_id, :tweet_id, :read, :identity_id

  #Relations
  belongs_to :identity#, counter_cache: true

  paginates_per 10

  def self.text_search(query)
    rank = <<-RANK
           ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
           ts_rank(to_tsvector(page_content), plainto_tsquery(#{sanitize(query)}))
    RANK
    where("to_tsvector('english', title) @@ :q or to_tsvector('english', page_content) @@ :q", q: query).order("#{rank} desc")
    #query.present? ? search(query) : all
  end
end
