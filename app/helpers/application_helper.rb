module ApplicationHelper
  def render_documents_as_gallery(documents = nil, template = nil)
    documents ||= @document_list
    template ||= 'shared/index_gallery'

    documents.each_with_index.map do |object, index|
      render(partial: template, locals: { document: object, document_counter: index })
    end.join.html_safe
  end

  def link_to_warper(url)
    # If we're already signed in on the Portal, bounce through the login page
    # to be sure we're signed in on the Warper
    url = "//#{WARPER_HOST_NAME}/ensure_sign_in?redirect_to=#{Rack::Utils.escape(url)}" if user_signed_in?

    if block_given?
      link_to url, rel: 'nofollow' do
        yield
      end
    else
      link_to t('search.viewinwarper'), url, rel: 'nofollow'
    end
  end
end
