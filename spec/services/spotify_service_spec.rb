require 'rails_helper'

RSpec.describe SpotifyService do
  let(:query) { 'red' }

  before { allow(RSpotify::Track).to receive(:search) }

  describe '.search' do
    it "calls spotify api" do
      expect(RSpotify::Track).to receive(:search).with(query, limit: 20)

      SpotifyService.search(query)
    end
  end
end
