class CollectionsController < CatalogController
  include CommonwealthVlrEngine::CollectionsControllerBehavior

  # return the CoDs as an array of SolrDocuments
  def cod_documents
    cod_q_params = ["#{blacklight_config.index.title_field}:\"Collections of Distinction\"",
                    "+destination_site_ssim:\"#{CommonwealthVlrEngine.config[:site]}\"",
                    '+curator_model_suffix_ssi:"Collection"']
    solr_resp = Blacklight.default_index.search(q: cod_q_params.join(' AND '),
                                                rows: 50,
                                                sort: 'title_info_primary_ssort asc')
    solr_resp.documents
  end

  # override; set higher per_page so all nblmc collections are included, use custom SearchBuilder
  def index
    blacklight_config.search_builder_class = CollectionsSearchBuilder
    params[:per_page] = 50
    super
  end
end
