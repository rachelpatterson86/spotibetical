class AddSongProperties < ActiveRecord::Migration
  def change
    add_column :songs, :preview_url, :string
    add_column :songs, :image_url, :string
    add_column :songs, :album, :string
  end
end
