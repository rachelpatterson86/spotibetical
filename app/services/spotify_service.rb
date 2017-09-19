class SpotifyService
  QUERY_LIMIT = 20

  def self.search(query)
    spotify_track.search(query, limit: QUERY_LIMIT)
  end

  private

  def self.spotify_track
    RSpotify::Track
  end
end
