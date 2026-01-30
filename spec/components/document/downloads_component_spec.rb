# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document::DownloadsComponent, type: :component do
  let(:mock_controller) { DownloadsController.new }
  let(:item_pid) { 'bpl-dev:df65v790j' }
  let(:document) { SolrDocument.new(id: item_pid, license_ss: 'Creative Commons') }
  let(:files_hash) do
    {
      image: [
        SolrDocument.new(id: 'bpl-dev:df65v790j', curator_model_ssi: 'Curator::Filestreams::Image',
                         attachments_ss: '{"characterization":{"filename":"characterization.xml","byte_size":4350,"content_type":"text/xml","checksum":"BpguN9xmGDq9Te37jqNR7w==","key":"images/bpl-dev:df65v791t/characterization.xml","service_name":"derivatives"},"image_access_800":{"filename":"image_access_800.jpg","byte_size":311126,"content_type":"image/jpeg","checksum":"ad+JwBpaxcINoAIm7T+LbA==","key":"images/bpl-dev:df65v791t/image_access_800.jpg","service_name":"derivatives"},"image_primary":{"filename":"06_01_007542.tif","byte_size":241067232,"content_type":"image/tiff","checksum":"8ZqE76F5Iu0P9EgshqUF5w==","key":"images/bpl-dev:df65v791t/image_primary.tif","service_name":"primary"},"image_service":{"filename":"image_service.jp2","byte_size":24134937,"content_type":"image/jp2","checksum":"rTz7RChFejmJfAE05zREow==","key":"images/bpl-dev:df65v791t/image_service.jp2","service_name":"derivatives"},"image_thumbnail_300":{"filename":"image_thumbnail_300.jpg","byte_size":52939,"content_type":"image/jpeg","checksum":"BOeB7ofPnUFxrC9072nQTg==","key":"images/bpl-dev:df65v791t/image_thumbnail_300.jpg","service_name":"derivatives"},"metadata_foxml":{"filename":"metadata_foxml.xml","byte_size":10959,"content_type":"application/xml","checksum":"u1oZFAWUnH4hXwl3YIiptw==","key":"images/bpl-dev:df65v791t/metadata_foxml.xml","service_name":"primary"}}',
                         storage_key_base_ss: 'images/bpl-dev:df65v791t', filename_base_ssi: '06_01_007542')
      ], audio: [], document: [], ereader: [], video: []
    }
  end

  context 'when non-restricted institution' do
    it 'renders the component' do
      render_inline(described_class.new(document: document, object_files: files_hash))

      expect(page).to have_css('li.download_list_item a.sidebar_downloads_link', count: 3)
      expect(page).to have_link(I18n.t('blacklight.downloads.images.image_primary'),
                                href: "/downloads/#{item_pid}?filestream_id=image_primary")
    end
  end

  context 'when restricted institution' do
    let(:document) do
      SolrDocument.new(id: item_pid, license_ss: 'Creative Commons', institution_name_ssi: 'British Library')
    end

    it 'renders the component' do
      render_inline(described_class.new(document: document, object_files: files_hash))

      expect(page).to have_css('li.download_list_item a.sidebar_downloads_link', count: 2)
      expect(page).to have_no_link(I18n.t('blacklight.downloads.images.image_primary'),
                                   href: "/downloads/#{item_pid}?filestream_id=image_primary")
    end
  end
end
