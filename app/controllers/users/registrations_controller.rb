# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
      session[:user_return_to] || user_path(resource)
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end
  end
end
