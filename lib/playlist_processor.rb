require 'date'

class PlaylistProcessor

  def self.send_playlist_to_spotify

  end

  def self.get_top_songs_by_letter
    Song.where(id: hightest_score_by_letter.values.map { |song| song[:id] } )
  end

  private

  def self.date_range_description
    current_date = DateTime.now
    start_date = current_date.strftime("%b #{current_date.day.ordinalize}")
    end_date = current_date
                .strftime("%b #{(current_date + 7.days).day.ordinalize}")

    "#{start_date} - #{end_date}"
  end

  def self.hightest_score_by_letter
    top_song_by_letter = {}

    Vote.current_week_tally.each do |song, score|
      letter = song[1].chars.first.downcase
      if top_song_by_letter[letter].nil? || top_song_by_letter[letter][:score] < score
        top_song_by_letter[letter] = { score: score, id: song[0] }
      end
    end

    top_song_by_letter
  end
end
