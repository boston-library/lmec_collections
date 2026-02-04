# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchButtonComponent, type: :component do
  it 'renders the component' do
    render_inline(described_class.new(id: 'search', text: 'submit'))

    expect(page).to have_css('button.btn-block')
  end
end
