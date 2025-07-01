class CollectionsController < CatalogController
  include CommonwealthVlrEngine::CollectionsControllerBehavior

  # return the CoDs as an array of SolrDocuments
  def cod_documents
    # commented out below, this approach doesn't work with Solr 7 and
    # currently used versions of Blacklight (6.3.3) and commonwealth-vlr-engine (f9d0ba2)
    # TODO: revert this once Blacklight and commonwealth-vlr-engine updated?

    # blacklight_config.search_builder_class = CommonwealthCollectionsSearchBuilder
    # cod_q_params = { blacklight_config.index.title_field => 'Collection of Distinction' }
    # _cod_response, cod_documents = search_results(q: cod_q_params,
    #                                               rows: 50,
    #                                               sort: 'title_info_primary_ssort asc')
    # cod_documents

    # new approach, works for now
    cod_q_params = "#{blacklight_config.index.title_field}:\"Collections of Distinction\""
    # add site filter to params
    cod_q_params << " AND +destination_site_ssim:\"#{CommonwealthVlrEngine.config[:site]}\""
    # add collections filter to params
    cod_q_params << ' AND +curator_model_suffix_ssi:"Collection"'
    solr_resp = Blacklight.default_index.search(q: cod_q_params,
                                                rows: 50,
                                                sort: 'title_info_primary_ssort asc')
    solr_resp.documents
  end

  # override; set higher per_page so all nblmc collections are included
  def index
    params[:per_page] = 50
    super
  end
end
