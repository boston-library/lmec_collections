module CatalogHelper
  include Blacklight::CatalogHelperBehavior
  include CommonwealthVlrEngine::CatalogHelperBehavior

  def galleries_toggle(galleries, type, item_id, opts = {})
    return nil unless galleries && !galleries.empty? && item_id

    if galleries.length == 1
      return gallery_toggle(galleries[0], type, item_id, opts)
    end

    favorited = galleries.any? { |g| favorited?(g, type, item_id) }
    icon_class = icon_class_for favorited
    context = opts[:context] || 'single'
    params = { type: type, item_id: item_id, context: context, tooltip: opts[:show_tooltip] }

    dom_id_value = "#{item_id}_galleries_modal"

    with_tooltip(opts[:show_tooltip], favorited, dom_id_value) do
      content_tag :span, id: (dom_id_value unless opts[:show_tooltip]) do
        link_to set_modal_galleries_path(params), data: { gallery_toggle: true, blacklight_modal: 'trigger' } do
          content_tag(:span, opts[:text], class: icon_class, data: { item_id: item_id, type: type })
        end
      end
    end
  end

  def gallery_toggle(gallery, type, item_id, opts = {})
    return nil unless gallery && type && item_id

    favorited = favorited?(gallery, type, item_id)
    icon_class = icon_class_for(favorited, opts[:icon_type])
    context = opts[:context] || 'single'
    tooltip = opts[:tooltip]
    params = { type: type, item_id: item_id, context: context, tooltip: tooltip }
    data_attrs = { item_id: item_id, type: type, gallery_id: gallery.id }

    dom_id_value = "#{item_id}_#{context}_#{gallery.id}_button"

    with_tooltip(opts[:show_tooltip], favorited, dom_id_value) do
      content_tag :span, id: (dom_id_value unless opts[:show_tooltip]) do
        link_to(
          favorited ? remove_item_gallery_path(gallery, params) : add_item_gallery_path(gallery, params),
          data: data_attrs.merge(turbo_method: :post, turbo_frame: 'blacklight-modal-frame')
        ) do
          content_tag(:span, opts[:text], class: icon_class)
        end
      end
    end
  end

  def render_argo_info?(document)
    document[:destination_site_ssim].include?('argo')
  end

  def iiif_manifest_url(document)
    manifest_uri = document.iiif_manifest_url
    manifest_uri&.include?('ark:/50959') ? "#{solr_document_url(document)}/manifest" : manifest_uri
  end

  private

  def icon_class_for(favorited, type = nil)
    if type == 'plus'
      favorited ? 'gallery-name remove-gallery' : 'gallery-name add-gallery'
    else
      favorited ? 'icon-star' : 'icon-star-empty'
    end
  end

  def favorited?(gallery, type, item_id)
    if type == 'repo_object'
      gallery.repo_objects.include?(item_id)
    else
      raise
    end
  end

  def with_tooltip(show, favorited = false, dom_id_value)
    link = yield
    if show
      title = if favorited
                'Remove from favorites list'
      else
                'Add to favorites list'
      end
      content_tag(:div, id: dom_id_value, class: ['favorite-document'], title: title,
                        'data-bs-toggle' => 'tooltip', 'data-bs-placement' => 'left') do
        link
      end
    else
      link
    end
  end
end
