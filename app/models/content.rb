class Content < ActiveRecord::Base
  attr_accessible :title, :page_content, :user_id, :tweet_id

  #Relations
  belongs_to :user, counter_cache: true

  def self.text_search(query)
    query.present? ? search(query) : scoped
  end
end
