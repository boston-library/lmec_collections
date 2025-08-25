require 'rails_helper'

RSpec.describe Redirect, type: :model do
  before { @redirect = Redirect.create!(drupal_id: '12345', repository_id: 'bpl-test:abcde6789') }

  it 'should have a drupal_id attribute' do
    expect(@redirect).to respond_to(:drupal_id)
  end

  it 'should have a repository_id attribute' do
    expect(@redirect).to respond_to(:repository_id)
  end

  it 'should have the correct drupal_id value' do
    expect(@redirect.drupal_id).to eq('12345')
  end

  it 'should have the correct repository_id value' do
    expect(@redirect.repository_id).to eq('bpl-test:abcde6789')
  end
end
