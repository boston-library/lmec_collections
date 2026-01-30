# frozen_string_literal: true

# use local class so we can remove :institution_limit from default CommonwealthVlrEngine::CollectionsSearchBuilder
class CollectionsSearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include CommonwealthVlrEngine::SearchBuilderBehavior

  self.default_processor_chain += %i[
    site_filter exclude_unpublished_items collections_filter starts_with
  ]
end
