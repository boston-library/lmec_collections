Rails.application.routes.draw do
  root to: 'pages#home'

  concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new

  # routes for CommonwealthVlrEngine
  mount CommonwealthVlrEngine::Engine => '/'

  # TODO: this bookmarks stuff should be in bpluser generator?
  # bookmarks item actions
  # this has to be in local app for bookmark item actions to work
  put 'bookmarks/item_actions', to: 'folder_items_actions#folder_item_actions', as: 'selected_bookmarks_actions'

  # Begin Blacklight routing
  mount Blacklight::Engine => '/'

  concern :iiif_search, BlacklightIiifSearch::Routes.new
  concern :searchable, Blacklight::Routes::Searchable.new
  concern :exportable, Blacklight::Routes::Exportable.new

  resource :catalog, only: [], as: 'catalog', path: '/search', controller: 'catalog' do
    concerns :searchable
    concerns :range_searchable
  end

  resources :solr_documents, only: [:show], path: '/search', controller: 'catalog' do
    concerns :exportable
    concerns :iiif_search
  end

  resources :bookmarks, only: [:index, :update, :create, :destroy] do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end
  # end Blacklight routing

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'sign_out', to: 'devise/sessions#destroy'
  end

  resources :galleries, path: 'favorites' do
    member do
      post 'add-item' => 'galleries#add_item', as: :add_item
      post 'remove-item' => 'galleries#remove_item', as: :remove_item
    end

    collection do
      get 'set-galleries-modal' => 'galleries#set_galleries_modal', as: :set_modal
    end
  end

  resources :users, only: [:show]

  resources :redirects, only: [:show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get '/manifest.json', to: 'pwa#manifest', defaults: { format: :json }
  mount Blacklight::Allmaps::Engine => '/'

  # redirect for legacy routes from previous bpl-mapportal app
  resources :exhibits, to: redirect('https://www.leventhalmap.org/exhibitions/')
  get 'educators', to: redirect('https://www.leventhalmap.org/education/')
  get 'educators/search', to: redirect('https://www.leventhalmap.org/education/')
  resources :curriculum_materials, path: 'educators/curriculum-materials', to: redirect('https://www.leventhalmap.org/education/')
  resources :map_sets, path: 'map-sets', to: redirect('https://www.leventhalmap.org/education/')
  resources :reproductions, to: redirect('https://www.leventhalmap.org/collections/reproductions/')
end
