class AllmapsDocumentComponent < CommonwealthVlrEngine::DocumentComponent
  renders_one :argo_info, lambda {
    Document::ArgoComponent.new(document: @document)
  }

  def before_render
    set_slot(:argo_info, nil)
    super
  end
end
