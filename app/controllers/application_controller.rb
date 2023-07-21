class ApplicationController < ActionController::Base

    before_action :check_concurrent_session

    private
  
    def check_concurrent_session
      if already_logged_in?
        # sign out the previously logged in user, only left the newly login user
        sign_out_and_redirect(current_user)
      end
    end
  
    def already_logged_in?
      # if current user is logged in, but the user login token in session 
      # doesn't match the login token in database,
      # which means that there is a new login for this user
      current_user && !(session[:login_token] == current_user.current_login_token)
    end
    rescue_from CanCan::AccessDenied do |exception|
        render json: { waring: exception, status: 'authorization_failed'}
    end
end
