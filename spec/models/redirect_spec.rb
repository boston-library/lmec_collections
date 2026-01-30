# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Redirect do
  let(:redirect) { described_class.create!(drupal_id: '12345', repository_id: 'bpl-test:abcde6789') }

  it 'has a drupal_id attribute' do
    expect(redirect).to respond_to(:drupal_id)
  end

  it 'has a repository_id attribute' do
    expect(redirect).to respond_to(:repository_id)
  end

  it 'has the correct drupal_id value' do
    expect(redirect.drupal_id).to eq('12345')
  end

  it 'has the correct repository_id value' do
    expect(redirect.repository_id).to eq('bpl-test:abcde6789')
  end
end
