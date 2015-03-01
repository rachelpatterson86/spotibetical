class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :votes
  has_many :songs, through: :votes

  def token?
    access_token && !token_expired?
  end

  def token_expired?
    Time.now > expires_at
  end

  def refresh!
    token_opts = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIFY_CLIENT_SECRET"],
      :grant_type => 'refresh_token',
      :refresh_token => self.refresh_token
    }
    response = HTTParty.post("https://accounts.spotify.com/api/token", 
                             :body => token_opts)
    self.update(:access_token => response[:access_token],
                :expires_at => Time.now + response[:expires_in])
  end

  def get_token!(auth_code)
    token_opts = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIF_CLIENT_SECRET"],
      :grant_type => 'authorization_code',
      :code => auth_code, 
      :redirect_uri => my_new_token_path(self)
    }
    response = HTTParty.post("https://accounts.spotify.com/api/token",
                             :body => token_opts)
    self.update(:access_token => response[:access_token],
                :refresh_token => response[:refresh_token],
                :expires_at => Time.now + response[:expires_in])
  end
end

#User.songs
#
# user
# has many votes
# has many songs
#
# votes
# belogs to users and song
#
# song
# has many votes
# belongs to user
