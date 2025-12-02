# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document::ArgoComponent, type: :component do
  let(:document) do
    SolrDocument.new(id: 'bpl-dev:123456', destination_site_ssim: %w[nblmc argo])
  end

  it 'renders the component' do
    render_inline(described_class.new(document: document))

    expect(page).to have_link I18n.t('argo.link'), href: "https://www.argomaps.org/maps/#{document[:id]}"
  end
end
