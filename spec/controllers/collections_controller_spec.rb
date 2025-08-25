require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  class CollectionsControllerTestClass < CollectionsController
  end

  let(:blacklight_config) { CatalogController.blacklight_config }
  let(:test_controller) { CollectionsControllerTestClass.new }

  # this is a very minimal test, not looking for any specific docs returned
  # since objects in Test repo are not super stable
  describe 'cod_documents' do
    it 'should return an array of SolrDocuments' do
      docs = test_controller.send(:cod_documents)
      expect(docs.class).to eq(Array)
    end
  end
end
