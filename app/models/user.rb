class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :votes
  has_many :songs, through: :votes
  has_one :song
  has_one :user_vote

  after_create :create_user_vote

  def create_user_vote
    UserVote.create(user: self)
  end

  def vetoed
    user_vote.update(veto: true)
  end

  def used_votes
    last_friday = date_of_last('Friday').to_time

    votes
      .where.not(score: 0)
      .where(created_at: last_friday..Time.current)
  end

  private
  def date_of_last(day)
    date  = Date.parse(day)
    delta = date > Date.today ? 7 : 0
    date - delta
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
