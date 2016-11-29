class Spotify::Authorization
  def refresh!(refresh_token)
    token_options = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIFY_CLIENT_SECRET"],
      :grant_type => 'refresh_token',
      :refresh_token => refresh_token
    }

    spotify_resquest(token_options)
  end

  def get_tokens!(auth_code, token_uri)
    token_options = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIF_CLIENT_SECRET"],
      :grant_type => 'authorization_code',
      :code => auth_code,
      :redirect_uri => token_uri
    }

    spotify_request(token_options)
  end

  private

  def spotify_request(token_opts)
    HTTParty.post("https://accounts.spotify.com/api/token", body: token_opts)
  end
end
