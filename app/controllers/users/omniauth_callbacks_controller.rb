class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @auth      = request.env["omniauth.auth"]
    @user      = find_or_create_user

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def find_or_create_user
    credential = Credential.find_by(provider: @auth.provider, uid: @auth.uid)
    return credential.user if credential.present?

    create_user
  end

  def create_user
    user = User.create_for_oauth(@auth)
    user.credentials.create(provider: @auth.provider, uid: @auth.uid)

    return user
  end
end
