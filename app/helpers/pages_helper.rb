module PagesHelper
  def cod_documents_for_home
    CollectionsController.new.cod_documents
  end
end
