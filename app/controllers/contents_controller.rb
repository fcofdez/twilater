class ContentsController < ApplicationController

  respond_to :html, :js

  def index
    @contents = Content.text_search(params[:query]).where(user: current_user).order('created_at DESC').page(1).per(5)
  end

  def show
    @content = Content.find(params[:id])
  end

end
