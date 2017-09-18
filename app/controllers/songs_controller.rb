class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def search
    @search_results = SpotifyService.search(params[:query])
  end

  def submit
    @song = Song.create(song_params)
    vote_service.vote(1)
    redirect_to :root
  end

  def vote
    @song = Song.find(params[:id])
    vote_service.vote(params[:vote])
    redirect_to :root
  end

  def veto
    @song = Song.find(params[:id])
    vote_service.veto
    redirect_to :root
  end

  private
  attr_reader :song

  def vote_service
    VoteService.new(current_user, song)
  end

  def song_params
    param_song = params.require(:song).permit(:artist, :title, :spotify_id)
    param_song.merge(user: current_user)
  end
end
