class UsersController < ApplicationController

  def search
    if params[:q]
      @query = RSpotify::Track.search(params[:q], limit: 20)
    end
    # respond_to do |format|
    #   format.html { render :search }
    #   format.js { render :results }
  end

  def update_token
    if params[:code]
      current_user.get_token!(params[:code])
      flash[:notice] = "Now that we're authenticated, you can share that playlist!"
      redirect_to playlists_path
    else
      flash[:alert] = "Cannot share playlist without spotify account access."
      redirect_to :root
    end
  end
end

# respond_to for HARD MODE. code in search method.

#play song, ex: https://open.spotify.com/track/61fVrohjzviG6WWoo8Ihnl
#@query.first.external_urls["spotify"]

#artist name
#@query.first.artists.artist_name
