Rails.application.routes.draw do
  # Users
  devise_for :users
  get 'users/:username' => 'users#show', as: 'show_user'

  # Playlists
  resources :playlists do
    member do
      patch 'end'
      post 'add_track'
    end
  end

  resources :playlist_songs, only: [:destroy] do
    member do
      patch 'move_higher'
      patch 'move_lower'
    end
  end
  resources :songs, only: [:show]
  resources :artists, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :labels, only: [:index, :show]

  root 'playlists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
