require 'rails_helper'

RSpec.describe Playlist, :type => :model do

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
  describe 'associations & validations' do
    it "has many songs" do
      assc = described_class.reflect_on_association(:songs)
      expect(assc.macro).to eq :has_many
    end
  end
end
