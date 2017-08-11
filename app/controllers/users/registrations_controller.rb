class Users::RegistrationsController < Devise::RegistrationsController
  layout 'devise'
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def edit
    respond_to do |format|
      format.html { render layout: 'user_profile' }
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit \
      :account_update,
      keys: %i[name photo status visible allow_subscriptions]
  end
end
