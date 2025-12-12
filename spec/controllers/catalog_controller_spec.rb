require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  # TODO: this spec is using the DC3 staging Solr index, use a local Solr instance instead
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
      expect(assigns(:mlt_response)).to_not be_falsey
    end
  end
end
