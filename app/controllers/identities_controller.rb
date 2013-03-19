class IdentitiesController < ApplicationController

  def index
    @identities = current_user.identities if user_signed_in?
  end

end
