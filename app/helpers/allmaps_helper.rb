# frozen_string_literal: true

module AllmapsHelper
  include Blacklight::Allmaps::AllmapsHelperBehavior

  # override so we can calculate allmaps_id from manifest url in Solr if needed
  def allmaps_id(document = @document)
    return document.sidecar_allmaps.allmaps_id if document.sidecar_allmaps.allmaps_id.present?

    return Digest::SHA1.hexdigest(document.iiif_manifest_url)[0..15] if document.iiif_manifest_url&.match?(/ark:/)

    nil
  end
end
