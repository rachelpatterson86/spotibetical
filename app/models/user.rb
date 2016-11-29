class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :votes
  has_many :songs, through: :votes
  has_one :song

  def at_vote_limit?
    votes.count < 5
  end

  def vetoed
    update(veto: true)
  end

  # def get_spotify_token!(auth_code)
  #   token_uri = my_new_token_path(self)
  #   response = Spotify::Authorization.get_token!(auth_code, token_uri)
  #
  #   update(
  #     :access_token => response[:access_token],
  #     :refresh_token => response[:refresh_token],
  #     :expires_at => Time.now + response[:expires_in]
  #   )
  # end
  #
  # def refresh_spotify!
  #   response = Spotify::Authorization.refresh!(refresh_token)
  #
  #   update(
  #     :access_token => response[:access_token],
  #     :expires_at => Time.now + response[:expires_in]
  #   )
  # end

  # def token?
  #   access_token && !token_expired?
  # end
  #
  # def token_expired?
  #   Time.now > expires_at
  # end
end
