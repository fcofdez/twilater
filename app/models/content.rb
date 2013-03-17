class Content < ActiveRecord::Base
  #Relations
  belongs_to :user, counter_cache: true

  attr_accessible :title, :page_content, :user_id, :tweet_id
end
