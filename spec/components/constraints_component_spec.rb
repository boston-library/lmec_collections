# frozen_string_literal: true

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConstraintsComponent, :vcr, type: :component do
  subject(:component) { described_class.new(**params) }

  # essentially same as #render_inline_to_capybara_node from Blacklight ViewComponentTestHelpers
  let(:rendered) { Capybara::Node::Simple.new(render_inline(component).to_s) }

  let(:params) do
    { search_state: search_state }
  end

  let(:blacklight_config) do
    CatalogController.blacklight_config.deep_copy.tap do |config|
      config.track_search_session.storage = false
    end
  end

  let(:search_state) { Blacklight::SearchState.new(query_params.with_indifferent_access, blacklight_config) }

  context 'with a query' do
    let(:query_params) { { q: 'Boston' } }

    it 'has a header' do
      expect(rendered).to have_css('.facets-heading', text: I18n.t('search.facetsheading'))
    end

    it 'wraps the output in a div' do
      expect(rendered).to have_css('div.panel-body')
    end
  end
end
