class Users::RegistrationsController < Devise::RegistrationsController
  protected

    def update_resource(resource, params)
      # This part remains the same: if a password is being changed, use the default Devise way.
      if params[:password].present? || params[:password_confirmation].present?
        super(resource, params)
      else
        # Get the permitted parameters for the account update.
        update_params = account_update_params

        # IMPORTANT: Manually remove the :current_password key from the hash.
        # This prevents the "unknown attribute" error.
        update_params.delete(:current_password)

        # Pass the cleaned-up hash to the update method.
        resource.update_without_password(update_params)
      end
    end
end
