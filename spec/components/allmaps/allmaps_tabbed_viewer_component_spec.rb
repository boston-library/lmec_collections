# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Allmaps::AllmapsTabbedViewerComponent, :vcr, type: :component do
  let(:item_pid) { 'bpl-dev:rn301202h' }
  let(:document) { SolrDocument.find(item_pid) }
  let(:mock_controller) { CatalogController.new }
  let(:files_hash) { mock_controller.get_files(item_pid) }

  it 'renders the viewers in a tabbed interface' do
    render_inline(described_class.new(document: document, object_files: files_hash))

    expect(page).to have_css("#item-viewer-tab-content #img_show_container")
    expect(page).to have_css("#georeferenced-tab-content #blacklight-allmaps-map")
  end
end
