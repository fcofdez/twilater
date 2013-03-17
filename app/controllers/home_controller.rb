class HomeController < ApplicationController

  def welcome
    redirect_to home_path if user_signed_in?
  end

  def index
    @contents = Content.text_search(params[:query]).where(user: current_user).order('created_at DESC').select :title
  end
end
