class Vote < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

validates_uniqueness_of :user_id, scope: :song_id

  def upvote
    
  end

end
