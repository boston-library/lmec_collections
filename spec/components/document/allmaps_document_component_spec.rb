# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommonwealthVlrEngine::Document::MetadataFieldComponent, type: :component do
  let(:item_pid) { 'TK' }
  let(:document) { SolrDocument.find(item_pid) }

  it 'renders the component' do
    render_inline(described_class.new(document: document))

    expect(page).to have_link I18n.t('argo.link'), href: "https://www.argomaps.org/maps/#{document[:id]}"
  end
end
