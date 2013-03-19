class Content < ActiveRecord::Base
  attr_accessible :title, :page_content, :user_id, :tweet_id, :read, :identity_id

  #Relations
  belongs_to :identity#, counter_cache: true

  paginates_per 10

  def self.text_search(query)
    query.present? ? search(query) : all
  end
end
