class BackgroundJobs::Favorites

  class << self

    def update_contents!
      User.find_each do |user|
        user.identities.each do |identity|
          process_favorites(identity, identity.favourite_tweets)
        end
      end
    end

    def process_favorites identity, tweets
      # We do reverse_each to insert contents in correct order
      tweets.reverse_each do |tweet|
        process_tweet identity, tweet
      end
    end

    def process_tweet identity, tweet
      BackgroundJobs::FavoritesParser.get_urls(tweet).each do |url|
        begin
          parsed_content = Readability.parse_url url
          Content.create!(title: parsed_content.title,
                          page_content: parsed_content.content,
                          tweet_id: tweet.id,
                          identity_id: identity.id)
        rescue Exception => e
          Rails.logger.error e.message
        end
      end
    end

  end
end
