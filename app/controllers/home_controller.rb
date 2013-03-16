class HomeController < ApplicationController

  def welcome
    redirect_to home_path if user_signed_in?
  end

  def index
    @tweets = current_user.favorite_tweets
  end
end
