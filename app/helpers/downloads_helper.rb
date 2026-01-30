# frozen_string_literal: true

module DownloadsHelper
  include CommonwealthVlrEngine::DownloadsHelperBehavior

  # Restrict full res downloads for certain institutions
  def filtered_image_filestreams(document, attachments_json)
    institutions = [document['institution_name_ssi']]
    download_restricted = Rails.application.config.download_restricted_institutions || []
    image_filestreams(attachments_json).select do |filestream_id|
      filestream_id != 'image_primary' || !institutions.intersect?(download_restricted)
    end
  end

  # override so we can call filtered_image_filestreams to get the list of downloadable filestreams
  def image_download_links(document, image_files)
    if document[:identifier_ia_id_ssi]
      [file_download_link(document[:id],
                          t('blacklight.downloads.images.access_full'),
                          nil,
                          'JPEG2000',
                          download_link_options)]
    else
      attachments_json = JSON.parse(image_files.first['attachments_ss'])
      image_links = []
      filtered_image_filestreams(document, attachments_json).each do |filestream_id|
        if image_files.length == 1
          attachments = attachments_json
          object_id = image_files.first['id']
        else
          attachments = setup_zip_attachments(image_files, filestream_id)
          object_id = document[:id]
        end
        image_links << file_download_link(object_id,
                                          t("blacklight.downloads.images.#{filestream_id}"),
                                          attachments,
                                          filestream_id,
                                          download_link_options)
      end
      image_links
    end
  end
end
