# frozen_string_literal: true

module Document
  class ArgoComponent < ViewComponent::Base
    def initialize(document:)
      @document = document
    end
    attr_reader :document

    def argo_show_url
      "https://www.argomaps.org/maps/#{document[:id]}"
    end

    def render?
      document[:destination_site_ssim].include?('argo')
    end
  end
end
