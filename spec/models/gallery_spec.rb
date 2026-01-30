# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gallery do
  let(:user) { User.create!(email: 'mike@mike.com', password: '123456') }
  let(:gal) { described_class.new(user:) }

  describe '#validates_name' do
    it 'is is valid with a name' do
      gal.name = 'Favorites'
      expect(gal).to be_valid
    end

    it 'is is invalid without a name' do
      gal.name = ''
      expect(gal).not_to be_valid

      gal.name = nil
      expect(gal).not_to be_valid
    end
  end

  describe '#default?' do
    let(:user) { User.create!(email: 'mike@mike.com', password: '123456') }
    let(:new_gallery) { described_class.create!(name: '2nd gallery', user: user) }

    it 'is the default gallery if it is the first one created' do
      new_gallery.user.galleries.reload
      expect(user.galleries.size).to eq(2)
      expect(user.galleries[0]).to be_default
      expect(user.galleries[1]).not_to be_default
      expect(user.galleries[1]).to eq(new_gallery)
    end
  end

  describe '#owned_by' do
    it 'scopes models by user' do
      gal_count = described_class.count
      User.create!(email: 'mike@mike.com', password: '12345678')
      user_two = User.create!(email: 'justin@justin.com', password: '12345678')
      expect(described_class.count).to eq(gal_count + 2)
      expect(described_class.owned_by(user_two).count).to eq(1)
    end
  end

  describe '#add_item' do
    let(:repo_object_id) { 'abc123' }

    it 'adds a repo object to a gallery' do
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
      expect(gal.repo_objects[0]).to eq(repo_object_id)
    end

    it 'raises if type is invalid' do
      expect do
        gal.add_item('NOT A VALID TYPE', repo_object_id)
      end.to raise_error(ArgumentError)
    end

    it 'does not add a duplicate repo object to a gallery' do
      gal.add_item('repo_object', repo_object_id)
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
    end
  end

  describe '#remove_item' do
    let(:repo_object_id) { 'abc123' }

    it 'removes a repo object from a gallery' do
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
      gal.remove_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(0)
    end

    it 'raises if type is invalid' do
      expect do
        gal.remove_item('NOT A VALID TYPE', repo_object_id)
      end.to raise_error(ArgumentError)
    end

    it 'does not raise when removing an item not in the gallery' do
      expect(gal.repo_objects.count).to eq(0)
      gal.remove_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(0)
    end
  end
end
