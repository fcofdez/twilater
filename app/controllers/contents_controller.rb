class ContentsController < ApplicationController

  respond_to :html, :js

  def index
    @contents = Content.select(:title, :read, :id).text_search(params[:query]).where(user: current_user).order('created_at DESC').page(params[:page])
    @next_page = params[:page].nil? ? 2 : params[:page].to_i + 1
  end

  def search
    @contents = Content.text_search(params[:query]).select(:title, :read, :id).where(user: current_user).order('created_at DESC').page(params[:page])
  end

  def show
    @content = Content.find(params[:id])
  end

end
