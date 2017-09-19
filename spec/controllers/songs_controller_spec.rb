require "rails_helper"

RSpec.describe SongsController, :type => :controller do
  let(:song_submitted_user) do
    User.create(email: 'test@test.com', password: 'password1')
  end

  let(:song) { Song.create(user: song_submitted_user, spotify_id: 12345) }

  login_voter

  describe 'GET index' do
    it 'renders root' do
      get :index
      expect(response).to render_template(:index)
      expect(response.content_type).to eq "text/html"
    end

    it "populates an array of songs" do
      song = Song.create(user_id: 1, spotify_id: 12345)
      get :index
      expect(assigns(:songs)).to eq([song])
    end
  end

  describe 'POST submit' do
    before { post :submit, { song: { spotify_id: 11111 } } }

    it 'redirects to root' do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
      expect(response.content_type).to eq "text/html"
    end

    context 'when a song CAN be submitted' do
      it 'creates a song' do
        expect{ song }.to change(Song, :count).by(1)
      end

      it 'creates a vote' do
        expect(Song.last.votes.count).to eq(1)
      end

      it 'upvotes a song' do
        expect(Song.last.votes.first.score).to eq(1)
      end
    end

    context 'when a song CANNOT be submitted' do
      it 'does NOT create a song' do
        song
        post :submit, { song: { user_id: song_submitted_user.id, spotify_id: 12345 } }
        expect{ song }.not_to change(Song, :count)
      end
      it 'does NOT create a vote' do
        post :submit, { song: { user_id: song_submitted_user.id, spotify_id: 12345 } }
        expect{ song.votes }.not_to change(Vote, :count)
      end
    end
  end

  describe 'POST vote' do
    it 'redirects to root' do
      post :vote, id: song.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
      expect(response.content_type).to eq "text/html"
      expect(assigns(:song)).to eq song
    end

    it 'creates a vote' do
      song.votes
      post :vote, id: song.id
      expect(song.votes.count).to eq(1)
    end
  end

  describe 'POST veto' do
    it 'redirects to root' do
      post :veto, id: song.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
      expect(response.content_type).to eq "text/html"
    end

    context 'when a song CAN be vetoed' do
      let!(:vetoable_song) do
        Vote.create(song: song, user: song_submitted_user, score: 1)
        Vote.create(song: song, user: User.new, score: 1)
      end

      it 'creates a vote' do
        song.votes
        post :veto, id: song.id
        expect(song.votes.count).to eq(3)
       end

     it 'vetos a song' do
       song.votes
       post :veto, id: song.id
       expect(song.votes.last.score).to eq(0)
      end
    end
  end
end