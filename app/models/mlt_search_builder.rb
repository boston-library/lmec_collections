# frozen_string_literal: true

# essentially the same as CommonwealthVlrEngine::MltSearchBuilder,
# but we remove the :institution_limit method from default_processor_chain
class MltSearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  # include BlacklightMaps::MapsSearchBuilderBehavior
  # include BlacklightRangeLimit::RangeLimitBuilder
  include CommonwealthVlrEngine::SearchBuilderBehavior

  self.default_processor_chain += %i[
    site_filter mlt_params exclude_unpublished_items exclude_institutions
  ]
end
