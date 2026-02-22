# frozen_string_literal: true

class Api::BaseController < ApplicationController
  # We don't need the standard browser CSRF protection for an API
  skip_before_action :verify_authenticity_token
  # Use our new token authentication method instead of the standard Devise one
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    user = nil
    authenticate_with_http_token do |token, _options|
      user = User.authenticate_by_token(token)
    end
    if user
      sign_in user, store: false
    else
      render json: { error: "Unauthorized." },
        status: :unauthorized
    end
  end
end
