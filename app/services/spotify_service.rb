class SpotifyService
  QUERY_LIMIT = 20

  def self.search(query)
    RSpotify::Track.search(query, limit: QUERY_LIMIT)
  end
end
