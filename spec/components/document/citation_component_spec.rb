# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document::CitationComponent, :vcr, type: :component do
  let(:item_pid) { 'bpl-dev:1c18f387q' }
  let(:document) { SolrDocument.find(item_pid) }

  it 'renders the citation content using the local URL' do
    render_inline(described_class.new(document: document))

    expect(page).to have_content("test.host/search/#{item_pid}")
  end
end
