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
    @content.update_attributes read: true
  end

  private

  def set_contents
    @contents = Content.search(params[:query]).select("contents.id", :title, :read).joins(:identity).where(identities: {user_id: current_user.id}).order('created_at DESC').page(params[:page])
  end
end
