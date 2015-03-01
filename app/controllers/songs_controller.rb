class SongsController < ApplicationController

  def submit
    @song = Song.create(song_params)
    @song.votes.create(:user_id => current_user.id,
                       :user_vote => 1)
    #@song.users = [current_user] better if there are no additional attributes
    render :show
  end

  def show
    @songs = Song.all
  end

  def upvote
    @song = Song.find(:id).vote
    #@song.users << current_user
    @song.votes.create(:user_id => current_user.id,
    :user_vote => 1)
  end

  def downvote
    @song.votes.create(:user_id => current_user.id,
    :user_vote => -1)
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
end

# sudo erb
# <table>
#   <tr>
#     <td>Rank</td>
#     <td>Artist</td>
#     <td>Song</td>
#     <td>Up Vote</td>
#     <td>Down Vote</td>
#   </tr>
#   <tr>
#     <%= <td>s.blahblahblahBANG</td> %>
#     <% @songs.each do |s| %>
  #     <%= <td>s.artist</td> %>
  #     <%= <td>s.title</td> %>
  #     <%= link_to("Up Vote",songs__path, method: :post) %>
  #     <%= link_to("Down Vote",songs_delete_path, method: :post) %>
#     <% end %>
#   </tr>
# </table>
