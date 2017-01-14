require 'rails_helper'
require 'playlist_processor'

RSpec.describe Playlist, :type => :model do
  describe 'associations & validations' do
    let(:song_submitted_user) do
      User.create(email: 'test@test.com', password: 'password1')
    end
    let(:voter) do
      User.create(email: 'voter@test.com', password: 'password1')
    end
    let(:song) { Song.create(user: song_submitted_user, spotify_id: 1) }
    let(:playlist) do
      Playlist.create(song: song, description: 'a playlist')
    end

    it "has many songs" do
      assc = described_class.reflect_on_association(:songs)
      expect(assc.macro).to eq :has_many
    end
  end

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

    before do
      allow(PlaylistProcessor)
        .to receive(:date_range_description)
        .and_return(description_dates)

      allow(PlaylistProcessor)
        .to receive(:get_top_songs_by_letter)
        .and_return(songs)

      allow(Playlist)
        .to receive(:create!)
        .and_return(playlist)

      described_class.create_playlist
    end

    it "creates playlist of the week" do
      expect(Playlist.count).to eq 1
    end

    it "adds songs to playlist" do
      expect(PlaylistSong.count).to eq 3
    end
  end
end
