class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create, :edit, :update]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :description, :name, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :description, :password, :password_confirmation, :current_password, :name, :profile_image])
  end

  def update_resource(resource, params)
    Rails.logger.debug "Received Params: #{params.inspect}"
    if params[:profile_image].present?
      Rails.logger.debug "Attaching profile image"
      resource.profile_image.attach(params[:profile_image])
    end

    # Check if a new password is being provided
    if params[:password].present?
      # If password is provided, current password must be included
      if params[:current_password].blank?
        resource.errors.add(:current_password, "can't be blank")
        return false
      end
    else
      # Remove password fields if they are not provided
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password) if params[:current_password].blank?
    end

    unless resource.save
      logger.error(resource.errors.full_messages)
      return false
    end

    # Call super to update the resource
    super
  end
end
