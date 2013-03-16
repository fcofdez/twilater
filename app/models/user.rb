class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :secret, :token

  def self.create_with_omniauth(auth)
    User.create!(provider: auth[:provider],
                 uid: auth[:uid],
                 token: auth[:credentials][:token],
                 secret: auth[:credentials][:secret],
                 name: auth[:info][:name])
  end

  def twitter_client
    @twitter ||= Twitter::Client.new(oauth_token: token, oauth_token_secret: secret)
  end

  def favorite_tweets
    twitter_client.favorites
  end
end
