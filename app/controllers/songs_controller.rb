class SongsController < ApplicationController
require 'vote_processor'
#re-write logic. user can't submit song if votes are used up.
# user can't veto song if song has been vetoed or they used their veto...
#prevent submit if song already selected...
#votes can be negative?
  def index
    @songs = Song.all
  end

  def search
    @query_results = RSpotify::Track.search(params[:q], limit: 20) if params[:q]
    # NOTE respond_to for HARD MODE. code in search method.

    # respond_to do |format|
    #   format.html { render :search }
    #   format.js { render :results }
  end

  def submit
    if Song.find_by_spotify_id(params[:song][:spotify_id]).nil?
      @song = Song.create(song_params)
      VoteProcessor.new(current_user, @song).vote(VoteProcessor::UP)
    end
    redirect_to :root
  end

  def show
  end

  def upvote
    @song = Song.find(params[:id])
    VoteProcessor.new(current_user, @song).vote(VoteProcessor::UP)
    redirect_to :root
  end

  def downvote
    @song = Song.find(params[:id])
    VoteProcessor.new(current_user, @song).vote(VoteProcessor::DOWN)
    redirect_to :root
  end

  def veto
    @song = Song.find(params[:id])
    VoteProcessor.new(current_user, @song).veto
    redirect_to :root
  end

  # def share
  #   if !current_user.access_token
  #     redirect_to build_auth_link
  #   elsif current_user.token_expired?
  #     current_user.refresh_spotify!
  #   end
  #
  #   @playlist = Playlist.find(params[:id])
  #   @playlist.share!(current_user)
  # end

  private

  def song_params
    params.require(:song).permit(:user_id, :artist, :title, :spotify_id)
  end

  # def build_auth_link
  #   auth_opts = {
  #     :client_id => ENV["SPOTIFY_CLIENT_ID"],
  #     :response_type => 'code',
  #     :redirect_uri => my_new_token_path(current_user),
  #     :scope => 'playlist-modify playlist-modify-public playlist-modify-private'
  #   }.to_query
  #
  #   "https://accounts.spotify.com/authorize?" + auth_opts
  # end
end

# TODO: add flash alerts about voting eligibility...
