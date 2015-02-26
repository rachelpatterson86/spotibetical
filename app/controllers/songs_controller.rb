class SongsController < ApplicationController

  def submit
    Song.create(song_params)
  end

private
    def song_params
      params.require(:songs).permit(:user_id, :artist, :title, :spotify_id)
    end

end
