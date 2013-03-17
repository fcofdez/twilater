class BackgroundJobs::Favorites

  class << self

    def update_contents!
      User.find_each do |user|
        process_favorites(user, user.favourite_tweets)
      end
    end

    def process_favorites user, tweets
      # We do reverse_each to insert in correct order contents
      tweets.reverse_each do |tweet|
        process_tweet user, tweet
      end
    end

    def process_tweet user, tweet
      BackgroundJobs::FavoritesParser.get_urls(tweet).each do |url|
        begin
          parsed_content = Readability.parse_url url
          Content.create!(title: parsed_content.title,
                          page_content: parsed_content.content,
                          tweet_id: tweet.id,
                          user_id: user.id)
        rescue Exception => e
          Rails.logger.error e.message
        end
      end
    end

  end
end
