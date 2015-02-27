class SongsController < ApplicationController

  def show
    @songs = Song.all
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
  #     <%= link_to("Up Vote",songs_show_path, method: :post) %>
  #     <%= link_to("Down Vote",songs_delete_path, method: :destroy) %>
#     <% end %>
#   </tr>
# </table>
#
