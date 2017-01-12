require 'date'

class PlaylistGenerator

  def send_playlist_to_spotify
    
  end

  def self.create_playlist
    playlist = Playlist.create!(description: date_range_description)

    get_top_songs_by_alphabet.each do |song|
      PlaylistSong.create!(playlist: playlist, song: song)
    end
  end

  def self.get_top_songs_by_alphabet
    songs = {}
    playlist_contenders = Vote.playlist_contenders

    playlist_contenders.each do |song, score|
      alphabet = song[1].chars.first.downcase

      if songs[alphabet].nil? || songs[alphabet][:score] < score
        songs[alphabet] = { score: score, id: song[0] }
      end
    end

    songs
  end

  private

  def self.date_range_description
    current_date = DateTime.now
    start_date = current_date.strftime("%b #{current_date.day.ordinalize}")
    end_date = current_date.strftime("%b #{(current_date + 7.days).day.ordinalize}")

    "#{start_date} - #{end_date}"
  end
end
