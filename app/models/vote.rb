class Vote < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

validates_uniqueness_of :user_id, scope: :song_id

  def self.vote_counter(user)
    if user.votes.count > 15
      return true
    end
  end


end
