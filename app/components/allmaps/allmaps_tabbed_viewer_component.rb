# frozen_string_literal: true

module Allmaps
  class AllmapsTabbedViewerComponent < ViewComponent::Base
    def initialize(document:, object_files:)
      @document = document
      @object_files = object_files
    end
    attr_reader :document, :object_files

    renders_one :media, lambda {
      CommonwealthVlrEngine::Document::MediaComponent.new(document: document, object_files: object_files)
    }

    renders_one :allmaps_viewer, lambda {
      Allmaps::AllmapsViewerComponent.new(document: document)
    }

    def render?
      document.georeferenced?
    end

    def before_render
      set_slot(:media, nil)
      set_slot(:allmaps_viewer, nil)
    end
  end
end
