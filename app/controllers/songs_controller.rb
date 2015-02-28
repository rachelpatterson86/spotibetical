class SongsController < ApplicationController

  def submit
    @song = Song.create(song_params)
    upvote(@song)
    #@song.users = [current_user] better if there are no additional attributes
    render :show
  end

  def show
    @songs = Song.all
  end

  def vote
    @song = Song.find(:id)
    upvote(@song)
    downvote(@song)
  end

private

    def song_params
      params.require(:song).permit(:user_id, :artist, :title, :spotify_id)
    end

    def upvote(song)
      song.votes.create(:user_id => current_user.id,
      :user_vote => 1)
    end

    def downvote(song)
      song.votes.create(:user_id => current_user.id,
      :user_vote => -1)
    end
end
