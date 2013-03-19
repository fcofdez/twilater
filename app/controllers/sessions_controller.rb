class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']

    @identity = Identity.find_with_omniauth(auth)

    @identity = Identity.create_with_omniauth(auth) if @identity.nil?

    if user_signed_in?

      if @identity.user == current_user
        # We are trying to link to user some existent identity
        message = "Already linked that account!"
      else
        # Link identity to user
        @identity.user = current_user
        @identity.save
        message = "Successfully linked that account!"
      end
      redirect_to identities_path, notice: message
    else
      if !@identity.user.present?
        # No user associated with the identity so we need to create a new one
        @identity.user = User.new
        @identity.save!
      end
      session[:user_id] = @identity.user.id
      self.current_user = @identity.user
      redirect_to root_url, notice: "Signed in!"
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
      redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
