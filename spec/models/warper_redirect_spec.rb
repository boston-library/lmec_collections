# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WarperRedirect do
  let(:redirect) { described_class.create!(warper_id: 12_345, repository_id: 'bpl-test:abcde6789') }

  it 'has a warper_id attribute' do
    expect(redirect).to respond_to(:warper_id)
  end

  it 'has a repository_id attribute' do
    expect(redirect).to respond_to(:repository_id)
  end

  it 'has the correct warper_id value' do
    expect(redirect.warper_id).to eq(12_345)
  end

  it 'has the correct repository_id value' do
    expect(redirect.repository_id).to eq('bpl-test:abcde6789')
  end
end
