require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'test@test.com', password: 'password1') }

  describe 'associations & validations' do
    it { should have_many(:votes) }
    it { should have_many(:songs).through(:votes) }
    it { should have_one(:song) }
# TODO: add devise tests
  end

  describe '#at_vote_limit?' do
    context 'when a user used less less than 5 votes' do
      it 'returns true' do
        expect(user.at_vote_limit?).to eq(true)
      end
    end

    context 'when user used more than VOTE_LIMIT' do
      before do
        Vote.create(user: user, song_id: 1, user_vote: 1)
        Vote.create(user: user, song_id: 2, user_vote: 1)
        Vote.create(user: user, song_id: 3, user_vote: 1)
        Vote.create(user: user, song_id: 4, user_vote: 1)
        Vote.create(user: user, song_id: 5, user_vote: 1)
      end

      it 'returns false' do
        expect(user.at_vote_limit?).to eq(false)
      end
    end
  end

  describe '#vetoed' do
    it 'sets veto to true' do
      expect(user.vetoed).to eq(true)
    end
  end

  describe '#used_votes' do
    before do
      Vote.create(user: user, song_id: 0, user_vote: 1, created_at: 8.days.ago.midnight)
      Vote.create(user: user, song_id: 1, user_vote: 1)
      Vote.create(user: user, song_id: 2, user_vote: -1)
      Vote.create(user: user, song_id: 3, user_vote: 1)
      Vote.create(user: user, song_id: 4, user_vote: 0)
    end

    it 'returns the vote records from last friday to today' do
      expect(user.used_votes.count).to eq(3)
    end
  end

  describe '#remaining_votes' do
    context 'when a user recently voted' do
      before do
        Vote.create(user: user, song_id: 0, user_vote: 1, created_at: 1.month.ago.midnight)
        Vote.create(user: user, song_id: 1, user_vote: 1)
        Vote.create(user: user, song_id: 2, user_vote: -1)
        Vote.create(user: user, song_id: 3, user_vote: 1)
        Vote.create(user: user, song_id: 4, user_vote: 0)
      end

      it 'returns the # of votes remaining' do
        expect(user.remaining_votes).to eq(2)
      end
    end

    context 'when a user has not recently voted' do
      it 'returns the # of votes remaining' do
        expect(user.remaining_votes).to eq(5)
      end
    end
  end
end
 #TODO add a scope to the assocations by adding a date.
