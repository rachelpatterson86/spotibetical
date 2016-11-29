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
end
