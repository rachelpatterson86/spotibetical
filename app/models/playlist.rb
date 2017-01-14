class Playlist < ActiveRecord::Base
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  def self.create_playlist
    Playlist
      .create!(description: PlaylistProcessor.date_range_description)
      .songs << PlaylistProcessor.get_top_songs_by_letter
  end
end
