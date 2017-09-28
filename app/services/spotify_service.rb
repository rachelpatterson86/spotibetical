class SpotifyService
  QUERY_LIMIT = 20

  def self.search(query)
    begin
      spotify_track.search(query, limit: QUERY_LIMIT).each do |track|
        track.instance_variable_set(:@submitted, submitted?(track.id))
      end
    rescue StandardError => e
    end
  end

  private

  def self.spotify_track
    RSpotify::Track
  end

  def self.submitted?(id)
    Song.find_by_spotify_id(id)&.votes&.recent_date_range ? true : false
  end
end
