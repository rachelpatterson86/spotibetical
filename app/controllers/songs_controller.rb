class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def search
    @songs = SpotifyService.search(params[:query]) unless params[:query].nil?
  end

  def submit
    if current_user
      @song = Song.create(song_params)
      vote_service.vote(1)
      redirect_to :root
    else
      flash[:notice] = 'Log in to submit a song.'
      render :search
    end
  end

  def vote
    if current_user
      @song = Song.find(params[:id])
      vote_service.vote(params[:vote])
    else
      flash[:notice] = 'Log in to submit a song.'
    end

    redirect_to :root
  end

  def veto
    if current_user
      @song = Song.find(params[:id])
      vote_service.veto
    else
      flash[:notice] = 'Log in to veto a song.'
    end

    redirect_to :root
  end

  private
  attr_reader :song

  def vote_service
    VoteService.new(current_user, song)
  end

  def song_params
    param_song = params.permit(:artist, :title, :spotify_id, :image_url, :preview_url, :album)
    param_song.merge(user: current_user)
  end
end
