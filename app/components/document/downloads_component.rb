# frozen_string_literal: true

# subclass so we can filter download-able image filestreams for specific institutions
module Document
  class DownloadsComponent < CommonwealthVlrEngine::Document::DownloadsComponent
    DOWNLOAD_RESTRICTED_INSTITUTIONS = ['Newberry Library', 'British Library'].freeze

    def image_filestreams(attachments_json)
      super.select do |filestream_id|
        filestream_id != 'image_primary' ||
          DOWNLOAD_RESTRICTED_INSTITUTIONS.exclude?(document['institution_name_ssi'])
      end
    end
  end
end
