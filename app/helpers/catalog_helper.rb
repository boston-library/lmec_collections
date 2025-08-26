module CatalogHelper
  include Blacklight::CatalogHelperBehavior
  include CommonwealthVlrEngine::CatalogHelperBehavior

  def link_to_warper_detail(item_id, tab = nil)
    url = "//#{WARPER_HOST_NAME}/maps/from_uuid/#{item_id}"
    url += "##{tab}" unless tab.blank?

    if block_given?
      link_to_warper url do
        yield
      end
    else
      link_to_warper url
    end
  end

  # override from CommonwealthVlrEngine::CatalogHelper
  # so we can remove 'Collection of Distinction' from collection names
  def setup_collection_links(document, link_class = nil)
    coll_hash = {}
    0.upto document[:collection_ark_id_ssim].length - 1 do |index|
      coll_hash_key = document[blacklight_config.collection_field.to_sym][index]
      coll_hash[coll_hash_key] = document[:collection_ark_id_ssim][index]
    end
    coll_links = []
    coll_hash.sort.each do |coll_array|
      coll_links << link_to(remove_cod_text(coll_array[0]),
                            collection_path(id: coll_array[1]),
                            class: link_class.presence)
    end
    coll_links
  end

  def warped_map_div(id, item_id)
    data = warped_map_data(item_id)
    content_tag(:div, nil, id: id, data: data)
  end

  def warped_map_data(item_id)
    url = "#{request.protocol}#{WARPER_HOST_NAME}/maps/tiles_for_uuid/#{item_id}"
    begin
      data = RestClient.get url, accept: :json
      JSON.parse(data)
    rescue RestClient::ResourceNotFound
      logger.error "The Solr index says that #{item_id} is warped but the warper API returned 404."
      { not_found: true }
    end
  end

  def galleries_toggle(galleries, type, item_id, opts = {})
    return nil unless galleries && !galleries.empty? && item_id

    if galleries.length == 1
      return gallery_toggle(galleries[0], type, item_id, opts)
    end

    favorited = galleries.any? { |g| favorited?(g, type, item_id) }
    icon_class = icon_class_for favorited
    params = { type: type, item_id: item_id }

    with_tooltip(opts[:show_tooltip]) do
      link_to set_modal_galleries_path(params), data: { gallery_toggle: true, blacklight_modal: "trigger" } do
        content_tag(:span, opts[:text], class: icon_class, data: { item_id: item_id, type: type })
      end
    end
  end

  def gallery_toggle(gallery, type, item_id, opts = {})
    return nil unless gallery && type && item_id

    favorited = favorited?(gallery, type, item_id)
    icon_class = icon_class_for(favorited, opts[:icon_type])
    params = { type: type, item_id: item_id }
    data = { item_id: item_id, type: type, gallery_id: gallery.id }

    gallery_action_path = if favorited
                            remove_item_gallery_path(gallery, params)
    else
                            add_item_gallery_path(gallery, params)
    end

    with_tooltip(opts[:show_tooltip], favorited) do
      link_to gallery_action_path,
              data: data.merge(turbo_method: :post) do
        content_tag(:span, opts[:text], class: icon_class)
      end
    end
  end

  def buy_repro_url(_document)
    # new_reproduction_path(map_pid: document['id'])
  end

  def render_argo_info?(document)
    document[:destination_site_ssim].include?("argo")
  end

  def iiif_manifest_url(document)
    manifest_uri = document[:identifier_iiif_manifest_ss]
    return nil if manifest_uri.blank?

    return manifest_uri unless manifest_uri.include?("ark:/50959")

    "#{solr_document_url(document)}/manifest"
  end

  private

  def icon_class_for(favorited, type = nil)
    if type == "plus"
      favorited ? "gallery-name remove-gallery" : "gallery-name add-gallery"
    else
      favorited ? "icon-star" : "icon-star-empty"
    end
  end

  def favorited?(gallery, type, item_id)
    if type == "repo_object"
      gallery.repo_objects.include?(item_id)
    else
      raise
    end
  end

  def with_tooltip(show, favorited = false)
    link = yield
    if show
      title = if favorited
                "Remove from favorites list"
      else
                "Add to favorites list"
      end
      content_tag(:div, class: [ "favorite-document" ], title: title,
                        "data-toggle" => "tooltip", "data-placement" => "left") do
        link
      end
    else
      link
    end
  end
end
