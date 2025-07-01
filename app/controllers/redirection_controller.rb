class RedirectionController < ApplicationController
  def ensure_sign_in
    url = if params[:redirect_to]
            params[:redirect_to]
          else
            Rack::Utils.escape('/')
          end

    if user_signed_in?
      redirect_to Rack::Utils.unescape(url)
    else
      redirect_to new_user_session_path(params)
    end
  end
end
