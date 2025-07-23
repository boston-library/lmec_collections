class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller

  # adds some site-wide behavior into the application controller
  include CommonwealthVlrEngine::Controller

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def guest_user
    user = super
    user.save(validate: false) unless user.persisted?

    user
  end

  def csv_param_to_int_array(params, param_name)
    if params[param_name]
      processed_params = params.dup
      processed_params[param_name] = processed_params[param_name].map { |p| p.split(",") }.flatten.map(&:to_i)
      processed_params
    else
      params
    end
  end
end
