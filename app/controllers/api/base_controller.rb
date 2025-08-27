class Api::BaseController < ApplicationController
  # We don't need the standard browser CSRF protection for an API
  skip_before_action :verify_authenticity_token
  # Use our new token authentication method instead of the standard Devise one
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    user = nil
    # The standard, professional way is to check for an "Authorization: Bearer <token>" header.
    authenticate_with_http_token do |token, options|
      user = User.find_by(api_token: token)
    end

    if user
      # If the user is found, sign them in for this one request.
      sign_in user, store: false
    else
      # If no user is found, send an unauthorized error.
      render json: { error: "Invalid API token." }, status: :unauthorized
    end
  end
end
