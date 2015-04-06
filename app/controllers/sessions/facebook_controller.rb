module Sessions
  class FacebookController < ApplicationController
    respond_to :js, :html, only: :create

    def create
      identity = Identity.find_by_omniauth(env['omniauth.auth'])

      if identity
        user = identity.user
      else
        user = SignUpUserViaFacebook.call(omniauth: env['omniauth.auth']).user
      end

      session[:user_id] = user.id
      cookies.permanent[:auth_token] = user.auth_token

      redirect_to root_path
    end
  end
end
