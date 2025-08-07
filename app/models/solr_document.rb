# frozen_string_literal: true

# Represents a single document returned from Solr
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Allmaps::SolrDocument
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
  
  def sidecar_allmaps
    # Find or create, and set version
    sidecar = Blacklight::Allmaps::Sidecar.where(
      solr_document_id: id,
    ).first_or_create do |sc|
      sc.solr_version = self._source["_version_"]
    end

    sidecar.solr_version = self._source["_version_"]
    sidecar.save

    sidecar
  end
end
