# frozen_string_literal: true

class CommonwealthSearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include BlacklightAdvancedSearch::AdvancedSearchBuilder
  include BlacklightMaps::MapsSearchBuilderBehavior
  include BlacklightRangeLimit::RangeLimitBuilder
  include CommonwealthVlrEngine::CommonwealthSearchBuilderBehavior

  self.default_processor_chain += [
    :site_filter, :exclude_unwanted_models, :exclude_unpublished_items,
    :add_advanced_parse_q_to_solr, :add_advanced_search_to_solr, :exclude_collections,
    :exclude_institutions
  ]
end
