class BackgroundJobs::FavoritesParser

  # Return an array with all url contained
  # in tweet text
  def self.get_urls(tweet)
    URI.extract(tweet.attrs[:text], %w(http https))
  end

end
