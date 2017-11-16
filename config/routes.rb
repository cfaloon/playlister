Rails.application.routes.draw do
  devise_for :users

  resources :playlists
  resources :songs, only: [:show]
  resources :artists, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :labels, only: [:index, :show]
  post 'add_song' => 'playlists#add_song'


  root 'playlists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
