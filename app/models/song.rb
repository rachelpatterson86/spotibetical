class Song < ActiveRecord::Base
  has_many :votes
  has_many :users, :through => :votes
  belongs_to :user

  validates_uniqueness_of :spotify_id
#TODO add some validations?
end
