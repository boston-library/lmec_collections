# frozen_string_literal: true

module ApplicationHelper
  def render_documents_as_gallery(documents = nil, template = nil)
    documents ||= @document_list
    template ||= 'shared/index_gallery'

    documents.each_with_index.map do |object, index|
      render(partial: template, locals: { document: object, document_counter: index })
    end.join.html_safe
  end
end
