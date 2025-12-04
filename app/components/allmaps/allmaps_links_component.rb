# frozen_string_literal: true

module Allmaps
  class AllmapsLinksComponent < ViewComponent::Base
    def initialize(document:)
      @document = document
    end
    attr_reader :document

    def render?
      document[:type_of_resource_ssim].include?('Cartographic') && document.iiif_manifest_url
    end
  end
end
