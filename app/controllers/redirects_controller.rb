# frozen_string_literal: true

class RedirectsController < ApplicationController
  def show
    @redirect = Redirect.where(drupal_id: params[:id]).first
    if @redirect
      redirect_to solr_document_path(@redirect.repository_id)
    else
      redirect_to root_path
    end
  end
end
