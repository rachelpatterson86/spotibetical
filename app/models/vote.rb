class Vote < ActiveRecord::Base
  belongs_to :songs
  belongs_to :users

validates_uniqueness_of :user_id, scope: :song_id
end
