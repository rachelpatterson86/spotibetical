require 'rails_helper'

RSpec.describe Vote, :type => :model do
  let(:song_submitted_user) do
    User.create(email: 'test@test.com', password: 'password1')
  end

  let(:voter) do
    User.create(email: 'voter@test.com', password: 'password1')
  end

  let(:song) { Song.create(user: song_submitted_user, spotify_id: 1) }

  describe 'associations & validations' do
    it { should belong_to(:song) }
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:song_id)}
  end

  describe 'scope' do
    describe '.vetoed' do
      before do
        Vote.create(user_id: 1, song_id: 1, score: 0)
        Vote.create(user_id: 2, song_id: 1, score: -1)
      end

      it 'returns all vetoed votes' do
        described_class.vetoed.should include(Vote.first)
        expect(described_class.vetoed.count).to eq(1)
      end
    end

    describe '.last_7_days' do
      before do
        Vote.create(user_id: 1, song_id: 1, score: 0)
        Vote.create(user_id: 2, song_id: 1, score: -1)
        Vote.create(user_id: 3, song_id: 1, score: -1, created_at: 8.days.ago)
      end

      it 'returns all votes from last 7 days' do
        described_class.last_7_days.should include(Vote.first)
        described_class.last_7_days.should include(Vote.second)
        expect(described_class.last_7_days.count).to eq(2)
      end
    end
  end
  describe '#current_week_tally' do
    before do
      Song.create(user_id: 1, spotify_id: 1, title: 'A')
      Song.create(user_id: 2, spotify_id: 2, title: 'aba')
      Song.create(user_id: 3, spotify_id: 3, title: 'B')
      Song.create(user_id: 4, spotify_id: 4, title: 'Bab')

      Vote.create(user_id: 1, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 1, score: -1)
      Vote.create(user_id: 3, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 2, score: 1)
      Vote.create(user_id: 3, song_id: 3, score: 1)
      Vote.create(user_id: 4, song_id: 4, score: 1)
    end

    it do
      result = Vote.current_week_tally
      expect(result.length).to eq(4)
      expect(result[[1, "A"]]).to eq(1)
      expect(result[[2, "aba"]]).to eq(1)
      expect(result[[3, "B"]]).to eq(1)
      expect(result[[4, "Bab"]]).to eq(1)
    end
  end

  context 'when total score is 0' do
    before do
      Song.create(user_id: 1, spotify_id: 1, title: 'A')
      Vote.create(user_id: 1, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 1, score: -1)
    end

    it 'does not include the song' do
      result = Vote.current_week_tally
      expect(result.count).to eq(0)
    end
  end

  context 'when total score < 0' do
    before do
      Song.create(user_id: 1, spotify_id: 1, title: 'A')

      Vote.create(user_id: 1, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 1, score: -1)
      Vote.create(user_id: 3, song_id: 1, score: -1)
    end

    it 'does not include the song' do
      result = Vote.current_week_tally
      expect(result.count).to eq(0)
    end
  end

  context 'when song has a veto' do
    before do
      Song.create(user_id: 1, spotify_id: 1, title: 'A')

      Vote.create(user_id: 1, song_id: 1, score: 1)
      Vote.create(user_id: 2, song_id: 1, score: 1)
      Vote.create(user_id: 3, song_id: 1, score: 0)
    end

    it 'does not include the song' do
      result = Vote.current_week_tally
      expect(result.count).to eq(0)
    end
  end
end
