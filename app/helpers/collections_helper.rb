# frozen_string_literal: true

module CollectionsHelper
  include CommonwealthVlrEngine::CollectionsHelperBehavior

  # override so we can make date_asc_sort the default sort
  def link_to_all_col_items(document, link_class: '')
    facet_params = { blacklight_config.collection_field => [document[blacklight_config.index.title_field.field]] }
    facet_params[blacklight_config.institution_field] = [document[blacklight_config.institution_field.to_sym]] if CommonwealthVlrEngine.config.dig(:institution, :pid).blank?
    search_params = { f: facet_params, sort: blacklight_config.date_asc_sort }
    link_to(t('blacklight.collections.browse.all'), search_catalog_path(search_params), class: link_class)
  end
end