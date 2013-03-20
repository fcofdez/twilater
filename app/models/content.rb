class Content < ActiveRecord::Base
  attr_accessible :title, :page_content, :user_id, :tweet_id, :read, :identity_id


  include PostgresqlFTS

  searchable do
    column :title
    column :page_content
  end

  #Relations
  belongs_to :identity

  paginates_per 10

end
