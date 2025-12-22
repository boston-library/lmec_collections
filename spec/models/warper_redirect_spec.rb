require 'rails_helper'

RSpec.describe WarperRedirect, type: :model do
  let(:redirect) { described_class.create!(warper_id: 12345, repository_id: 'bpl-test:abcde6789') }

  it 'should have a warper_id attribute' do
    expect(redirect).to respond_to(:warper_id)
  end

  it 'should have a repository_id attribute' do
    expect(redirect).to respond_to(:repository_id)
  end

  it 'should have the correct warper_id value' do
    expect(redirect.warper_id).to eq(12345)
  end

  it 'should have the correct repository_id value' do
    expect(redirect.repository_id).to eq('bpl-test:abcde6789')
  end
end
