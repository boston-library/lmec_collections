class AllmapsDocumentComponent < CommonwealthVlrEngine::DocumentComponent
  renders_one :allmaps_sidebar, -> do
    Allmaps::SidebarComponent.new(document: @document)
  end

  renders_one :allmaps_viewer, -> do
    Allmaps::ViewerComponent.new(document: @document)
  end

  def before_render
    set_slot(:allmaps_sidebar, nil)
    set_slot(:allmaps_viewer, nil)

    super
  end
end
