require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'test@test.com', password: 'password1') }

  describe 'associations & validations' do
    it { should have_many(:votes) }
    it { should have_many(:songs).through(:votes) }
    it { should have_one(:song) }
    it { should have_one(:user_vote) }
# TODO: add devise tests
  end

  describe '#after_create' do
    it 'calls create_user_vote' do
      expect(user).to receive(:create_user_vote)
      user.save
    end
  end

  describe '#create_user_vote' do
    it "creates a user_vote record" do
      user.save
      expect(user.user_vote.present?).to eq(true)
    end
  end

  describe '#vetoed' do
    before { UserVote.new(user: user) }

    it { expect(user.vetoed).to eq(true) }
  end

  describe '#used_votes' do
    before do
      Vote.create(user: user, song_id: 0, score: 1, created_at: 8.days.ago.midnight)
      Vote.create(user: user, song_id: 1, score: 1)
      Vote.create(user: user, song_id: 2, score: -1)
      Vote.create(user: user, song_id: 3, score: 1)
      Vote.create(user: user, song_id: 4, score: 0)
    end

    it 'returns the vote records from last friday to today' do
      expect(user.used_votes.count).to eq(3)
    end
  end
end
 #TODO add a scope to the assocations by adding a date.
