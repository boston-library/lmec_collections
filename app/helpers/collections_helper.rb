module CollectionsHelper
  include CommonwealthVlrEngine::CollectionsHelperBehavior

  # filter the list of collection documents
  # if cod_flag true, return CoDs, if false return all other collections
  # @param [Array<SolrDocument>] documents list of documents to render
  # @param [TrueClass || FalseClass]
  def cod_filter(documents, cod_flag = false)
    test_string = 'Collection of Distinction'
    if cod_flag
      documents.select { |doc| doc[blacklight_config.index.title_field.field] =~ /#{test_string}/ }
    else
      documents.select { |doc| doc[blacklight_config.index.title_field.field] !~ /#{test_string}/ }
    end
  end

  # remove "(Collection of Distinction)" from display value
  # @param [String] col_name
  def remove_cod_text(col_name)
    col_name.gsub(/ \(Collection of Distinction\)/, '')
  end

  # replaces render_document_index in institutions/index partial
  # so we can use local CoD partials for display
  # @param [Array<SolrDocument>] documents list of documents to render
  def render_cod_index(documents = nil)
    render partial: 'catalog/document_gallery_cod',
           locals: { documents: documents }
  end
end
