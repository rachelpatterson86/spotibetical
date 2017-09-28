require 'rails_helper'

RSpec.describe SpotifyService do
  let(:query) { 'red' }

  let(:spotify_result) do
    [ SpotifyResult.new(12345), SpotifyResult.new(343242) ]
  end

  let(:search_result) do
    spotify_result[0].submitted = false
    spotify_result[1].submitted = true

    spotify_result
  end

  subject { described_class.search(query) }

  describe '.search' do
    context 'when there is a query' do
      before do
        allow(RSpotify::Track).to receive(:search).and_return(spotify_result)
        user = User.new
        song = Song.create(spotify_id: spotify_result[1].id, user: user)
        Vote.create(song: song, score: 1, user: user)

        subject
      end

      it { is_expected.to eq(search_result) }
    end

    context 'when query is blank' do
      let(:query) { '' }

      before do
        allow(RSpotify::Track)
          .to receive(:search)
            .and_raise(StandardError.new('I AM AN ERROR'))
      end

      it 'does not return an error' do
        expect{subject}.not_to raise_error
      end

      it { is_expected.to be_nil }
    end
  end
end

class SpotifyResult
  attr_reader :id
  attr_accessor :submitted
  
  def initialize(id, submitted=nil)
    @id = id
    @submitted = submitted
  end
end
