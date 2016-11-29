class UsersController < ApplicationController

# TODO: may need to check out the logic for update token...
  # def update_token
  #   if params[:code]
  #     current_user.get_spotify_token!(params[:code])
  #     flash[:notice] = "Now that we're authenticated, you can share that playlist!"
  #     redirect_to playlists_path
  #   else
  #     flash[:alert] = "Cannot share playlist without spotify account access."
  #     redirect_to :root
  #   end
  # end
end

#play song, ex: https://open.spotify.com/track/61fVrohjzviG6WWoo8Ihnl
#@query.first.external_urls["spotify"]

#artist name
#@query.first.artists.artist_name
