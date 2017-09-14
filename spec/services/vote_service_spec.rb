require 'rails_helper'
# TODO: add votes of different time ranges... i.e. last month...

RSpec.describe VoteService do
  let!(:voter) { User.create(email: 'voter_email@test.com', password: 'password1') }

  let!(:song) do
    user = User.create(email: 'email@test.com', password: 'password1')
    song = Song.create(user: user, spotify_id: 12345)
    Vote.create(song: song, user: user, score: 1)

    song
  end

  let(:user) { User.create(email: 'email@test.com', password: 'password1') }

  subject { VoteService.new(voter, song) }

  describe '#vote' do
    context 'when a song is eligible for voting' do
      it 'adds a vote' do
        expect{ subject.vote(1) }.to change { Vote.count }.by(1)
      end
    end

    context 'when a song has been vetoed' do
      it 'does NOT add a vote' do
        Vote.create(song: song, user: User.new, score: 0)
        expect{ subject.vote(1) }.to_not change { Vote.count }
      end
    end

    context 'when a user has already voted for the song' do
      it 'does NOT add a vote' do
        Vote.create(song: song, user: voter, score: 0)

        expect{ subject.vote(1) }.to_not change { Vote.count }
      end
    end

    context 'when the user has no more votes' do
      it 'does NOT add a vote' do
        5.times { |i| voter.votes << Vote.new(score: 1, song_id: i) }

        expect{ subject.vote(1) }.to_not change { Vote.count }
      end
    end
  end

  describe 'veto' do
    context 'when a song CAN be vetoed' do
      it 'creates a vote with a 0 score' do
        subject.veto

        expect(song.votes.count).to eq(2)
        expect(song.votes.last.score).to eq(0)
      end
    end

    context 'when a song CANNOT be vetoed' do
      it 'does NOT create a vote' do
        Vote.create(song: song, user: User.new, score: 0)

        expect{ subject.veto }.to_not change { Vote.count }
      end
    end
  end

  describe '#remaining_votes' do
    context 'when a user recently voted' do
      before do
        Vote.create(user: voter, song_id: 0, score: 1, created_at: 1.month.ago.midnight)
        Vote.create(user: voter, song_id: 1, score: 1)
        Vote.create(user: voter, song_id: 2, score: -1)
        Vote.create(user: voter, song_id: 3, score: 1)
        Vote.create(user: voter, song_id: 4, score: 0)
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
