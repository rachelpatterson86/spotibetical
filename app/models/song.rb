class Song < ActiveRecord::Base
  has_many :votes
  has_many :voters, :through => :votes, class_name: 'User'
end
