# frozen_string_literal: true

# redirect old geo.leventhalmap.org/maps/:id requests to catalog#show
class WarperRedirectsController < ApplicationController
  def show
    @redirect = WarperRedirect.where(warper_id: params[:id]).first
    if @redirect
      redirect_to solr_document_path(@redirect.repository_id)
    else
      redirect_to root_path
    end
  end
end
