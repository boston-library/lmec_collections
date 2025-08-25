require 'rails_helper'

RSpec.describe Gallery, type: :model do
  let(:user) { User.create!(email: 'mike@mike.com', password: '123456') }
  let(:gal) { Gallery.new(user:) }

  describe '#validates_name' do
    it 'is is valid with a name' do
      gal.name = 'Favorites'
      expect(gal).to be_valid
    end

    it 'is is invalid without a name' do
      gal.name = ''
      expect(gal).to be_invalid

      gal.name = nil
      expect(gal).to be_invalid
    end
  end

  describe '#default?' do
    let(:user) { User.create!(email: 'mike@mike.com', password: '123456') }
    let(:new_gallery) { Gallery.create!(name: '2nd gallery', user: user) }

    it 'is the default gallery if it is the first one created' do
      new_gallery.user.galleries.reload
      expect(user.galleries.size).to eq(2)
      expect(user.galleries[0]).to be_default
      expect(user.galleries[1]).not_to be_default
      expect(user.galleries[1]).to eq(new_gallery)
    end
  end

  describe '#owned_by' do
    it 'should scope models by user' do
      gal_count = Gallery.all.count
      User.create!(email: 'mike@mike.com', password: '12345678')
      user_2 = User.create!(email: 'justin@justin.com', password: '12345678')
      expect(Gallery.all.count).to eq(gal_count + 2)
      expect(Gallery.owned_by(user_2).count).to eq(1)
    end
  end

  describe '#add_item' do
    let(:repo_object_id) { 'abc123' }
    let(:curriculum_material) do
      CurriculumMaterial.create! title: 'Material',
                                 material_type: 1,
                                 attachment: File.new(Rails.root + 'spec/fixtures/blank.pdf')
    end

    it 'should add a repo object to a gallery' do
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
      expect(gal.repo_objects[0]).to eq(repo_object_id)
    end

    it 'should raise if type is invalid' do
      expect do
        gal.add_item('NOT A VALID TYPE', repo_object_id)
      end.to raise_error(ArgumentError)
    end

    it 'should not add a duplicate repo object to a gallery' do
      gal.add_item('repo_object', repo_object_id)
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
    end
  end

  describe '#remove_item' do
    let(:repo_object_id) { 'abc123' }

    it 'should remove a repo object from a gallery' do
      gal.add_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(1)
      gal.remove_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(0)
    end

    it 'should raise if type is invalid' do
      expect do
        gal.remove_item('NOT A VALID TYPE', repo_object_id)
      end.to raise_error(ArgumentError)
    end

    it 'should not raise when removing an item not in the gallery' do
      expect(gal.repo_objects.count).to eq(0)
      gal.remove_item('repo_object', repo_object_id)
      expect(gal.repo_objects.count).to eq(0)
    end
  end
end
