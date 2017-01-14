require 'rails_helper'
require 'playlist_processor'

RSpec.describe PlaylistProcessor do

  describe '.send_playlist_to_spotify' do
    it "calls spotify api and does a get request to spotify of the songs in the current playlist" do

    end
  end

  describe '.get_top_songs_by_letter' do

    before do
      Song.create(user_id: 1, spotify_id: 1, title: 'A')
      Song.create(user_id: 2, spotify_id: 2, title: 'aba')
      Song.create(user_id: 3, spotify_id: 3, title: 'B')
      Song.create(user_id: 4, spotify_id: 4, title: 'Bab')

      Vote.create(user_id: 1, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 1, score: -1)
      Vote.create(user_id: 2, song_id: 2, score: 1)
      Vote.create(user_id: 3, song_id: 3, score: 1)
      Vote.create(user_id: 4, song_id: 4, score: 1)
    end

    it 'returns the song with the highest score' do
      results = PlaylistProcessor.get_top_songs_by_letter
      expect(results.count).to eq(2)
      expect(results.first).to eq(Song.find(2))
      expect(results.second).to eq(Song.find(3))
    end
  end
end

#* Add an endpoint to view playlists from past week and a button to click that adds the playlist to the current user's spotify account. Top 5 songs only.
# * (This will involve OAuth authentication flows.)
# (then add SEVERAL weeks of playlists...)
# clean up. add associations?
 #
# todo:
# logic to GENERATE PLAYLIST, controller, view

# the top rated song is chosen for each letter A-Z and added to a playlist; that playlist is pushed to Spotify

#generate playlist based on top rated song, a-z.
#get top rated song for each letter A-Z for the past week.
#with those results, set data in a playlist join table.
