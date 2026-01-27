# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Allmaps::AllmapsLinksComponent, :vcr, type: :component do
  let(:item_pid) { 'bpl-dev:rn301202h' }
  let(:document) { SolrDocument.find(item_pid) }

  it 'renders the allmaps/sidebar/allmaps partial' do
    render_inline(described_class.new(document: document))

    expect(page).to have_css("#allmaps-sidebar")
  end
end
