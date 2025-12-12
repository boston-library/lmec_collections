class CollectionsController < CatalogController
  include CommonwealthVlrEngine::CollectionsControllerBehavior

  # override; set higher per_page so all nblmc collections are included, use custom SearchBuilder
  def index
    blacklight_config.search_builder_class = CollectionsSearchBuilder
    params.merge!(view: 'gallery', sort: blacklight_config.title_sort, per_page: 100)
    collection_search_service = search_service_class.new(config: blacklight_config, user_params: params)
    @featured_collections = collection_search_service.fetch(helpers.featured_objects_from_config(context: 'root',
                                                                                                 type: 'collections'))
    @response = collection_search_service.search_results
    @other_collections = @response.documents.select { |d| @featured_collections.none? { |fc| fc.id == d.id } }

    respond_to do |format|
      format.html
    end
  end
end
