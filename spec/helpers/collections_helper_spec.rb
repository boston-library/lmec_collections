# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectionsHelper do
  let(:blacklight_config) { CatalogController.blacklight_config }
  let(:document) do
    { blacklight_config.index.title_field.field => 'Foo Collection',
      blacklight_config.institution_field.to_sym => 'Bar Institution',
      blacklight_config.hosting_status_field.to_sym => 'harvested' }
  end

  before do
    without_partial_double_verification do
      allow(helper).to receive_messages(blacklight_config: blacklight_config)
    end
  end

  describe '#link_to_all_col_items' do
    it 'creates a search link with the correct default sort' do
      expect(helper.link_to_all_col_items(document)).to include('sort=date_start_dtsi+asc')
    end
  end
end
