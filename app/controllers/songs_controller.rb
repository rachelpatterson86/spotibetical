class SongsController < ApplicationController

  def submit
    @song = Song.create(song_params)
    upvote(@song)
    #@song.users = [current_user] better if there are no additional attributes
    vote_limit
    render :show
  end

  def show
    @songs = Song.all
  end

  def vote
    @song = Song.find(:id)
    if current_user.find_by(veto: true)
      flash[:alert] = "You've used your veto this week. Should have thought about it more wisely."
    elsif @song.votes.find_by(user_vote: 0)
      flash[:notice] = "Song has been veto and cannot be voted until next week."
    elsif upvote(@song) || downvote(@song)
      vote_limit
    end
  end

  def veto
    @song = Song.find(:id)
    if current_user.veto == true
      flash[:alert] = "You've used your veto this week. Should have thought about it more wisely."
    else
      @song.votes.create(:user_id => current_user.id, user_vote: 0)
      current_user@user.update(veto: true)
      #User.find(current_user.id).update(veto: 0)
      flash[:notice] = "You've used your single veto for this week."
    end
  end

  def share
    if !current_user.access_token
      redirect_to build_auth_link
    elsif current_user.token_expired?
      current_user.refresh!
    end
    @playlist = Playlist.find(params[:id])
    @playlist.share!(current_user)
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :artist, :title, :spotify_id)
  end

  def build_auth_link
    auth_opts = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :response_type => 'code',
      :redirect_uri => my_new_token_path(current_user),
      :scope => 'playlist-modify playlist-modify-public playlist-modify-private'
    }.to_query
    "https://accounts.spotify.com/authorize?" + auth_opts
  end

  def upvote(song)
    song.votes.create(:user_id => current_user.id,
                      :user_vote => 1)
  end

  def downvote(song)
    song.votes.create(:user_id => current_user.id,
                      :user_vote => -1)
  end

  def vote_limit
    if Vote.vote_counter(current_user)
      flash[:alert] = "You've used all 15 votes this week."
    end
  end
end

