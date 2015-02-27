class SongsController < ApplicationController


  def submit
    @song = Song.create(song_params)#:user_id, :artist, :title, :spotify_id)
    render :show
  end

private
    def song_params
      params.require(:song).permit(:user_id, :artist, :title, :spotify_id)
    end

end
