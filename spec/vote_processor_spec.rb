require 'rails_helper'
require 'vote_processor'

RSpec.describe VoteProcessor do
  let(:user) { User.create(email: 'email@test.com', password: 'password1') }
  let(:song) { Song.create(user: user, spotify_id: 12345) }
  let(:current_voter) { User.create(email: 'voter_email@test.com', password: 'password1') }

  subject { VoteProcessor.new(current_voter, song) }

  before { UserVote.new(user: current_voter) }

  describe '#initialize' do
    it { expect(subject.user).to eq(current_voter) }
    it { expect(subject.song).to eq(song) }
  end

  describe '#vote' do
    context 'when a song CAN be voted' do
      let!(:voteable_song) { Vote.create(song: song, user: user, score: 1) }

      it 'creates a vote' do
        subject.vote(1)
        expect(song.votes.count).to eq(2)
      end
    end

    context 'when a song CANNOT be voted' do
      let!(:vetoed_song) { Vote.create(song: song, user: user, score: 0) }

      it 'does NOT create a vote' do
        subject.vote(1)
        expect(song.votes.count).to eq(1)
      end
    end
  end

  describe 'veto' do
    context 'when a song CAN be vetoed' do

      before do
        Vote.create(song: song, user: user, score: 1)
        subject.veto
      end

      it 'creates a vote' do
        expect(subject.song.votes.count).to eq(2)
        expect(subject.song.votes.last.score).to eq(0)
        expect(current_voter.user_vote.veto).to eq(true)
      end
    end

    context 'when a song CANNOT be vetoed' do
      before do
        Vote.create(song: song, user: user, score: 0)
        subject.veto
      end

      it 'does NOT create a vote' do
        expect(song.votes.count).to eq(1)
      end
    end
  end

  describe '#add_bonus' do
    context 'when up votes are divisible by 3, to give bonus votes' do
      before do
        Vote.create(song: song, user: user, score: 1)
        Vote.create(song: song, user: current_voter, score: 1)
        Vote.create(song: song, user_id: 3, score: -1)
        Vote.create(song: song, user_id: 4, score: 1)

        subject.add_bonus
      end

      it 'adds a bonus vote for the song submitter' do
        expect(user.user_vote.bonus_votes).to eq(1)
      end
    end

    context 'when up votes are NOT divisible by 3, DO NOT give bonus votes' do
      before do
        Vote.create(song: song, user: user, score: 1)
        Vote.create(song: song, user: current_voter, score: 1)
        Vote.create(song: song, user_id: 3, score: -1)

        subject.add_bonus
      end

      it 'does not change bonus vote' do
        bonus = user.user_vote.bonus_votes
        expect(user.user_vote.bonus_votes).to eq(bonus)
      end

      it 'returns nil' do
        expect(subject.add_bonus).to eq(nil)
      end
    end
    #TODO call on an upvote.
  end

  describe '#remove_bonus' do
    before do
      UserVote.create(user: current_voter, bonus_votes: bonus_votes)

      subject.remove_bonus
    end

    context 'when bonus is greater than 0' do
      let(:bonus_votes) { 2 }

      it 'subtracts a bonus vote by 1' do
        expect(subject.user.user_vote.bonus_votes).to eq(1)
      end
    end

    context 'when bonus is nil' do
      let(:bonus_votes) { nil }

      it { expect(subject.remove_bonus).to eq(nil) }
    end

    context 'when bonus is 0' do
      let(:bonus_votes) { 0 }

      it { expect(subject.remove_bonus).to eq(nil) }
    end
  end

  describe '#remaining_votes' do
    context 'when a user recently voted' do
      before do
        Vote.create(user: current_voter, song_id: 0, score: 1, created_at: 1.month.ago.midnight)
        Vote.create(user: current_voter, song_id: 1, score: 1)
        Vote.create(user: current_voter, song_id: 2, score: -1)
        Vote.create(user: current_voter, song_id: 3, score: 1)
        Vote.create(user: current_voter, song_id: 4, score: 0)
      end

      it 'returns the # of votes remaining' do
        expect(subject.remaining_votes).to eq(2)
      end
    end

    context 'when a user has not recently voted' do
      it 'returns the # of votes remaining' do
        expect(subject.remaining_votes).to eq(5)
      end
    end
  end
end
