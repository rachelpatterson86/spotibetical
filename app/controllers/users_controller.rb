class UsersController < ApplicationController

  def search
    if params[:q]
      @query = RSpotify::Track.search(params[:q], limit: 20)
    end
  end
  
end

#play song, ex: https://open.spotify.com/track/61fVrohjzviG6WWoo8Ihnl
#@query.first.external_urls["spotify"]

#artist name
#@query.first.artists.artist_name
