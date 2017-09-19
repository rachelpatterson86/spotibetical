require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "05fa9f52e704407f886aece1d2b2d858", "291cfd43ea104610afd11631da4480af", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
