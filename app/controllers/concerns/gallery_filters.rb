# frozen_string_literal: true

module GalleryFilters
  extend ActiveSupport::Concern

  included do
    def set_galleries
      @galleries = Gallery.owned_by(current_or_guest_user).order(:name)
    end
  end
end
