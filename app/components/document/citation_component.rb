# frozen_string_literal: true

# subclass to override #url_for_citation
module Document
  class CitationComponent < CommonwealthVlrEngine::Document::CitationComponent
    # prefer solr_document_url
    def url_for_citation
      solr_document_url(@document)
    end
  end
end
