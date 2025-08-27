class Api::BaseController < ApplicationController
  # We don't need the standard browser CSRF protection for an API
  skip_before_action :verify_authenticity_token
  # Use our new token authentication method instead of the standard Devise one
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    # Check for the token in the URL parameters for easy testing
    user_token = params[:api_token].presence
    user = user_token && User.find_by(api_token: user_token)

    if user
      # If the user is found, sign them in for this request
      sign_in user, store: false
    else
      # If the user isn't found, send an unauthorized error
      render json: { error: "Invalid API token." }, status: :unauthorized
    end
  end
end
