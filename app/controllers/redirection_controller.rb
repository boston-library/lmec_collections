# frozen_string_literal: true

class RedirectionController < ApplicationController
  def ensure_sign_in
    url = params[:redirect_to] || Rack::Utils.escape('/')

    if user_signed_in?
      redirect_to Rack::Utils.unescape(url)
    else
      redirect_to new_user_session_path(params)
    end
  end
end
