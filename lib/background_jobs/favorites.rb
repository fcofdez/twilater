class BackgroundJobs::Favorites

  class << self

    def run!
      User.find_each do |user|
        process_favorites(user, user.favourite_tweets)
      end
    end

    def process_favorites user, tweets
      tweets.each do |tweet|
        BackgroundJobs::FavoritesParser.get_urls(tweet).each do |url|
          parsed_content = Readability.parse_url url
          Content.create!(title: parsed_content.title,
                          page_content: parsed_content.content,
                          tweet_id: tweet.id,
                          user_id: user.id)
        end
      end
    end

  end
end
