require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create_default_gallery' do
    let(:user) { User.create!(email: 'mike@mike.com', password: '123456') }

    it 'creates a default gallery when saving' do
      expect(user.galleries.size).to eq(1)
      expect(user.galleries[0]).to be_a(Gallery)
      expect(user.galleries[0].name).to eq(Gallery.default_name)
    end
  end
end
