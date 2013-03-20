class Identity < ActiveRecord::Base

  # Relations
  belongs_to :user
  has_many :contents, ->{ order "created_at DESC" }

  # Due to Twitter api constraints
  MAX_TWEETS = 100

  attr_accessible :provider, :uid, :nickname, :secret, :token, :user_id

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], 
           provider: auth['provider'],
           token: auth[:credentials][:token],
           secret: auth[:credentials][:secret],
           nickname: auth[:info][:nickname])
  end

  def has_contents?
    !(contents.size == 0)
  end

  def all_favourite_tweets
    twitter_client.favorites count: MAX_TWEETS
  end

  # Options could be
  # count: Integer less or equal than 100
  # since_id: will return all tweets since given id
  def favourite_tweets_since id
    twitter_client.favorites since_id: id.to_s
  end

  def favourite_tweets
    return all_favourite_tweets unless has_contents?
    favourite_tweets_since contents.first!.tweet_id
  end

  private

  def twitter_client
    @twitter ||= Twitter::Client.new(oauth_token: token, oauth_token_secret: secret)
  end

end
