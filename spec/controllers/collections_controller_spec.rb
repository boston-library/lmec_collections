# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectionsController, :vcr do
  describe 'GET "index"' do
    it 'shows the collections page' do
      get :index
      expect(response).to be_successful
      expect(assigns(:featured_collections)).to be_a(Array)
      expect(assigns(:other_collections)).to be_a(Array)
    end
  end
end
