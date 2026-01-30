# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatalogController, :vcr do
  let(:item_pid) { 'bpl-dev:1c18f387q' }

  describe 'mlt_search' do
    it 'modifies the config to use the correct search builder class' do
      get :index, params: { mlt_id: item_pid }
      expect(controller.blacklight_config.search_builder_class).to eq(MltSearchBuilder)
    end
  end

  describe 'mlt_results_for_show' do
    it 'retrieves the mlt results for the item' do
      get :show, params: { id: item_pid }
      expect(assigns(:mlt_response)).not_to be_falsey
    end
  end
end
