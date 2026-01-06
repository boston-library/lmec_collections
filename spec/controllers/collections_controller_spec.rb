require 'rails_helper'

RSpec.describe CollectionsController, :vcr, type: :controller do
  describe 'GET "index"' do
    it 'should show the collections page' do
      get :index
      expect(response).to be_successful
      expect(assigns(:featured_collections)).to be_a_kind_of(Array)
      expect(assigns(:other_collections)).to be_a_kind_of(Array)
    end
  end
end
