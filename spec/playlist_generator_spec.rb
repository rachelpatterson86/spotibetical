require 'rails_helper'
require 'playlist_generator'

RSpec.describe PlaylistGenerator do

  describe '.create_playlist' do
    let(:description_dates) { 'Jan 2nd - Jan 9th' }
    let(:playlist) { Playlist.create(description: description_dates) }

    let(:songs) do
      [
        Song.create(user_id: 1, spotify_id: 1, title: 'A'),
        Song.create(user_id: 2, spotify_id: 2, title: 'B'),
        Song.create(user_id: 3, spotify_id: 3, title: 'C')
      ]
    end

    let(:playlist_songs) do
      PlaylistSong.create!(playlist: playlist, song: songs[0])
      PlaylistSong.create!(playlist: playlist, song: songs[1])
      PlaylistSong.create!(playlist: playlist, song: songs[2])
    end

    before do
      allow(PlaylistGenerator)
        .to receive(:date_range_description)
        .and_return(description_dates)

      allow(PlaylistGenerator)
        .to receive(:get_top_songs_by_alphabet)
        .and_return(songs)

      allow(Playlist)
        .to receive(:create!)
        .and_return(playlist)

        allow(PlaylistSong)
          .to receive(:create!)
          .and_return(playlist_songs)
    end

    it "creates playlist of the week" do
      expect(Playlist)
        .to receive(:create!)
        .with({description: description_dates})

      PlaylistGenerator.create_playlist
      expect(Playlist.count).to eq 1
    end

    it "adds songs to playlist" do
      expect(PlaylistSong.count).to eq 3
    end
  end

  describe '.send_playlist_to_spotify' do
    it "calls spotify api and does a get request to spotify of the songs in the current playlist" do

    end
  end

  describe '.get_top_songs_by_alphabet' do

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
      results = PlaylistGenerator.get_top_songs_by_alphabet
      expect(results.count).to eq(2)
      expect(results['a']).to eq({:score=>1, :id=>2})
      expect(results['b']).to eq({:score=>1, :id=>3})
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
