# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

    def update_resource(resource, params)
      if params[:password].present? || params[:password_confirmation].present?
        super(resource, params)
      else
        update_params = account_update_params
        update_params.delete(:current_password)
        resource.update_without_password(update_params)
      end
    end
end
