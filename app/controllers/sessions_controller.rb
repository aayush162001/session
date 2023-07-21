class SessionsController < Devise::SessionsController
    skip_before_action :check_concurrent_session

    # POST /resource/sign_in
    def create
      super
      # after the user signs in successfully, set the current login token
      set_login_token
    end
  
    private
    def set_login_token
      token = Devise.friendly_token
      session[:login_token] = token
      current_user.current_login_token = token
      current_user.save
    end
end
