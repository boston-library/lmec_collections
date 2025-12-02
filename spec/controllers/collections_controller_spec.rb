require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  # TODO: this spec is using the DC3 staging Solr index, use a local Solr instance instead

  describe 'GET "index"' do
    it 'should show the collections page' do
      get :index
      expect(response).to be_successful
      expect(assigns(:featured_collections)).to be_a_kind_of(Array)
      expect(assigns(:other_collections)).to be_a_kind_of(Array)
    end
  end
end
