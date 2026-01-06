# frozen_string_literal: true

require 'rails_helper'

# not testing much; this is a subclass of CommonwealthVlrEngine::AdvancedSearchFormComponent w/few changes
RSpec.describe AdvancedSearchFormComponent, :vcr, type: :component do
  subject(:render) do
    component.render_in(view_context)
  end

  def vc_test_controller_class
    CatalogController
  end

  let(:component) { described_class.new(url: '/foo', response: response, params: params) }
  let(:response) { Blacklight::Solr::Response.new({ facet_counts: { facet_fields: { format: { 'Book' => 10, 'CD' => 5 } } } }.with_indifferent_access, {}) }
  let(:params) { {} }

  let(:rendered) do
    Capybara::Node::Simple.new(render)
  end

  let(:view_context) { vc_test_controller.view_context }

  before(:each) do
    without_partial_double_verification do
      allow(view_context).to receive(:facet_limit_for).and_return(nil)
    end
  end

  it 'has search_index_select fields with the correct options' do
    expect(rendered).to have_select 'clause_0_field', options: ['All Fields', 'Title', 'Subject', 'Place', 'Creator']
  end
end
