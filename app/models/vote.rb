class Vote < ActiveRecord::Base
  has_many :songs
  has_many :users
end
