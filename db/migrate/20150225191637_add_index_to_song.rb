class AddIndexToSong < ActiveRecord::Migration
  def change
    add_index :songs, :spotify_id, :unique => true
  end
end
