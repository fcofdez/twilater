class ContentsController < ApplicationController

  respond_to :html, :js

  before_filter :set_contents, only: [:index, :search]

  def index
    @next_page = @contents.current_page + 1
  end

  def search
  end

  def show
    @content = Content.find(params[:id])
  end

  private

  def set_contents
    @contents = Content.text_search(params[:query]).select(:title, :read, :id).where(user: current_user).order('created_at DESC').page(params[:page])
  end
end
