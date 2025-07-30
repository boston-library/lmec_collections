# frozen_string_literal: true

class SearchButtonComponent < Blacklight::SearchButtonComponent
  def call
    tag.button(class: "btn btn-secondary btn-block search-field-btn", type: "submit", id: @id) do
      render(Blacklight::Icons::SearchComponent.new) +
        tag.span(@text, class: "visually-hidden-sm me-sm-1 submit-search-text")
    end
  end
end
