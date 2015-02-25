class Playlist < ActiveRecord::Base
  has_many :songs, through :suggestions
end
