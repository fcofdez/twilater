class HomeController < ApplicationController

  def welcome
    redirect_to contents_path if user_signed_in?
  end

end
