Rails.application.routes.draw do
  devise_for :users
  get '/search' => "songs#search"
  root "songs#index"
  post '/songs' => 'songs#submit'
  get '/songs' => 'songs#show'
  post '/songs/:id' => 'songs#vote', as: :vote
  post '/songs/:id/veto' => 'songs#veto'
  get '/playlists' => 'playlists#index', as: :playlists
  post '/playlists/:id' => 'playlists#send_to_spotify', as: :playlist
  get '/auth/spotify/callback', to: 'users#spotify'
end
