json.array!(@galleries) do |gallery|
  json.extract! gallery, :id
  json.url gallery_url(gallery, format: :json)
end
