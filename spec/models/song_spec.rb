require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song_submitted_user) do
    User.create(email: 'test@test.com', password: 'password1')
  end

  let(:voter) do
    User.create(email: 'voter@test.com', password: 'password1')
  end

  let(:song) { Song.create(user: song_submitted_user, spotify_id: 1) }

  describe 'associations & validations' do
    it "has many votes" do
      assc = described_class.reflect_on_association(:votes)
      expect(assc.macro).to eq :has_many
    end

    it "has many users" do
      assc = described_class.reflect_on_association(:users)
      expect(assc.macro).to eq :has_many
    end

    it "belongs to a user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it { should validate_uniqueness_of(:spotify_id)}
  end
end
