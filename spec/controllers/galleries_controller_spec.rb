# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GalleriesController, :vcr do
  fixtures :users, :galleries

  let(:user) do
    users(:joe)
  end

  # This should return the minimal set of attributes required to create a valid
  # Gallery. As you add validations to Gallery, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'name', user_id: user.id }
  end

  let(:invalid_attributes) do
    { name: nil, user: nil }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GalleriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all galleries as @galleries' do
      login_with user
      get :index, params: {}, session: valid_session

      expect(assigns(:galleries)).to eq([galleries(:joes_favorites)])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested gallery as @gallery' do
      gallery = Gallery.create! valid_attributes
      login_with user
      get :show, params: { id: gallery.to_param }, session: valid_session
      expect(assigns(:gallery)).to eq(gallery)
    end
  end

  describe 'GET #new' do
    it 'assigns a new gallery as @gallery' do
      get :new, params: {}, session: valid_session
      expect(assigns(:gallery)).to be_a_new(Gallery)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested gallery as @gallery' do
      gallery = Gallery.create! valid_attributes
      login_with user
      get :edit, params: { id: gallery.to_param }, session: valid_session
      expect(assigns(:gallery)).to eq(gallery)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Gallery' do
        login_with user
        expect do
          post :create, params: { gallery: valid_attributes }, session: valid_session
        end.to change(Gallery, :count).by(1)
      end

      it 'assigns a newly created gallery as @gallery' do
        login_with user
        post :create, params: { gallery: valid_attributes }, session: valid_session
        expect(assigns(:gallery)).to be_a(Gallery)
        expect(assigns(:gallery)).to be_persisted
      end

      it 'redirects to the created gallery' do
        login_with user
        post :create, params: { gallery: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Gallery.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved gallery as @gallery' do
        login_with user
        post :create, params: { gallery: invalid_attributes }, session: valid_session
        expect(assigns(:gallery)).to be_a_new(Gallery)
      end

      it "re-renders the 'new' template" do
        login_with user
        post :create, params: { gallery: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'better name' }
      end

      it 'updates the requested gallery' do
        login_with user
        gallery = Gallery.create! valid_attributes
        put :update, params: { id: gallery.to_param, gallery: new_attributes }, session: valid_session
        gallery.reload
        expect(gallery.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested gallery as @gallery' do
        gallery = Gallery.create! valid_attributes
        login_with user
        put :update, params: { id: gallery.to_param, gallery: valid_attributes }, session: valid_session
        expect(assigns(:gallery)).to eq(gallery)
      end

      it 'redirects to the gallery' do
        gallery = Gallery.create! valid_attributes
        login_with user
        put :update, params: { id: gallery.to_param, gallery: valid_attributes }, session: valid_session
        expect(response).to redirect_to(gallery)
      end
    end

    context 'with invalid params' do
      it 'assigns the gallery as @gallery' do
        gallery = Gallery.create! valid_attributes
        login_with user
        put :update, params: { id: gallery.to_param, gallery: invalid_attributes }, session: valid_session
        expect(assigns(:gallery)).to eq(gallery)
      end

      it "re-renders the 'edit' template" do
        gallery = Gallery.create! valid_attributes
        login_with user
        put :update, params: { id: gallery.to_param, gallery: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested gallery' do
      gallery = Gallery.create! valid_attributes
      login_with user
      expect do
        delete :destroy, params: { id: gallery.to_param }, session: valid_session
      end.to change(Gallery, :count).by(-1)
    end

    it 'redirects to the galleries list' do
      gallery = Gallery.create! valid_attributes
      login_with user
      delete :destroy, params: { id: gallery.to_param }, session: valid_session
      expect(response).to redirect_to(galleries_url)
    end
  end

  describe 'POST #add_item' do
    let(:gallery) { Gallery.create! valid_attributes }
    let(:valid_params) do
      { id: gallery.to_param, type: 'repo_object', item_id: 'abc123', format: :js }
    end

    before do
      login_with user
      request.accept = 'application/json'
    end

    it 'adds a repo_object to the gallery' do
      post :add_item, params: valid_params, session: valid_session, format: :turbo_stream
      gallery.reload
      expect(gallery.repo_objects).to eq(['abc123'])
      expect(response).to have_http_status(:ok)
    end

    it 'renders the add_item template' do
      post :add_item, params: valid_params, session: valid_session, format: :turbo_stream
      expect(response).to render_template('add_item')
    end

    it 'does not add a duplicate items' do
      post :add_item, params: valid_params, session: valid_session, format: :turbo_stream
      post :add_item, params: valid_params, session: valid_session, format: :turbo_stream
      gallery.reload
      expect(gallery.repo_objects).to eq(['abc123'])
    end
  end

  describe 'POST #remove_item' do
    let(:gallery) { Gallery.create! valid_attributes }
    let(:item_id) { 'abc123' }
    let(:valid_params) do
      { id: gallery.to_param, type: 'repo_object', item_id: item_id, format: :js }
    end

    before do
      login_with user
      request.accept = 'application/json'
    end

    it 'removes a repo_object from the gallery' do
      gallery.update(repo_objects: [item_id])
      gallery.reload
      expect(gallery.repo_objects).to eq([item_id])
      post :remove_item, params: valid_params, session: valid_session, format: :turbo_stream
      gallery.reload
      expect(gallery.repo_objects).to eq([])
      expect(response).to have_http_status(:ok)
    end

    it 'renders the remove_item template' do
      post :remove_item, params: valid_params, session: valid_session, format: :turbo_stream
      expect(response).to render_template('remove_item')
    end

    it 'allows multiple remove requests without error' do
      gallery.update(repo_objects: [item_id])
      gallery.reload
      expect(gallery.repo_objects).to eq([item_id])
      post :remove_item, params: valid_params, session: valid_session, format: :turbo_stream
      post :remove_item, params: valid_params, session: valid_session, format: :turbo_stream
      gallery.reload
      expect(gallery.repo_objects).to eq([])
    end
  end
end
