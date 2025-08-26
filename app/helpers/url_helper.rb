module UrlHelper
  include CommonwealthVlrEngine::BlacklightUrlHelper

  def session_tracking_path(document, params = {})
    notrack_controllers = %w[institutions collections primary_source_sets galleries pages]
    return if notrack_controllers.include?(controller_name)

    super
  end
end
