require 'rails_helper'

RSpec.describe RedirectsController, type: :controller do
  describe 'GET #show' do
    describe 'with a valid drupal id' do
      before do
        @redirect = Redirect.create!(drupal_id: '12736', repository_id: 'bpl-test:zs25x875t')
      end
      it 'should redirect to the repository item show view' do
        get :show, params: { id: @redirect.drupal_id }
        expect(response).to redirect_to(solr_document_path(id: @redirect.repository_id))
      end
    end

    describe 'with an invalid drupal id' do
      it 'should redirect to the home page' do
        get :show, params: { id: 'foo' }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
