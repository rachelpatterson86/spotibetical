require 'rails_helper'
require 'vote_processor'

RSpec.describe VoteProcessor do
  let(:user) { User.new(email: 'email@test.com', password: 'password1') }
  let(:song) { Song.new(user: user, spotify_id: 12345) }
  let(:current_voter) { User.new(email: 'voter_email@test.com', password: 'password1') }

  let(:vote_processor) { VoteProcessor.new(current_voter, song) }

  describe '#initialize' do
    it { expect(vote_processor.user).to eq(current_voter) }
    it { expect(vote_processor.song).to eq(song) }
  end

  describe '#vote' do
    context 'when a song CAN be voted' do
      let!(:voteable_song) { Vote.create(song: song, user: user, user_vote: 1) }

      it 'creates a vote' do
        vote_processor.vote(1)
        expect(song.votes.count).to eq(2)
      end
    end

    context 'when a song CANNOT be voted' do
      let!(:vetoed_song) { Vote.create(song: song, user: user, user_vote: 0) }

      it 'does NOT create a vote' do
        vote_processor.vote(1)
        expect(song.votes.count).to eq(1)
      end
    end
  end

  describe 'veto' do
    context 'when a song CAN be vetoed' do
      let!(:voteable_song) do
        Vote.create(song: song, user: user, user_vote: 1)
      end

      it 'creates a vote' do
        vote_processor.veto
        expect(song.votes.count).to eq(2)
      end

      it 'vetoes a song' do
        vote_processor.veto
        expect(song.votes.last.user_vote).to eq(0)
      end

      it 'sets user.veto to false' do
        vote_processor.veto
        expect(current_voter.veto).to eq(true)
      end
    end

    context 'when a song CANNOT be vetoed' do
      let!(:vetoed_song) { Vote.create(song: song, user: user, user_vote: 0) }

      it 'does NOT create a vote' do
        vote_processor.veto
        expect(song.votes.count).to eq(1)
      end
    end
  end
end
