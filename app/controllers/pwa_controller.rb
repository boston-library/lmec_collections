class PwaController < ApplicationController
  def manifest
    respond_to do |format|
      format.json
    end
  end
end
