Rails.application.routes.draw do
  devise_for :users
  get '/songs/search' => "songs#search"
  root "songs#index"
  post '/songs' => 'songs#submit'
  get '/songs' => 'songs#show'
  post '/songs/:id' => 'songs#upvote', as: :upvote
  post '/songs/:id' => 'songs#downvote', as: :downvote
  post '/songs/:id/veto' => 'songs#veto'
  get '/playlists' => 'playlists#index', as: :playlists
  post '/playlists/:id' => 'playlists#send_to_spotify', as: :playlist
end
