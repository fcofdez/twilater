class HomeController < ApplicationController

  def welcome
    redirect_to home_path if user_signed_in?
  end

  def index
    @contents = current_user.contents
  end
end
