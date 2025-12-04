class AllmapsDocumentComponent < CommonwealthVlrEngine::DocumentComponent
  renders_one :argo_info, lambda {
    Document::ArgoComponent.new(document: @document)
  }

  renders_one :allmaps_links, lambda {
    Allmaps::AllmapsLinksComponent.new(document: @document)
  }

  renders_one :allmaps_viewer, -> do
    Allmaps::AllmapsViewerComponent.new(document: @document)
  end

  def before_render
    set_slot(:argo_info, nil)
    set_slot(:allmaps_links, nil)
    set_slot(:allmaps_viewer, nil)
    super
  end
end
