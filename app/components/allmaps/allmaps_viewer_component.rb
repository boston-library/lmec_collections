# frozen_string_literal: true

module Allmaps
  class AllmapsViewerComponent < ViewComponent::Base
    def initialize(document:)
      @document = document
    end
    attr_reader :document
  end
end
