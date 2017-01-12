class Song < ActiveRecord::Base
  has_many :votes
  has_many :users, :through => :votes
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  belongs_to :user

  validates_uniqueness_of :spotify_id
#TODO add some validations?
end
