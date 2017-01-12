# spotibetical

## Description

Build a community-generated playlist sharing site.

* Read you some docs: [Asset Pipeline][assets], [Unobtrusive JS][ujs], [Tim's notes from Week 2][tim-w2]

[rspotify]: https://github.com/guilhermesad/rspotify
[spotify-api]: https://developer.spotify.com/

[assets]: http://guides.rubyonrails.org/asset_pipeline.html
[ujs]: http://edgeguides.rubyonrails.org/working_with_javascript_in_rails.html#built-in-helpers
[tim-w2]: https://github.com/tiy-atl-js-q1-2015/Notes/tree/master/Week%2002

Day 5/6:
* Hard-mode things

## Requirements

### Normal Mode

- [x] Users have accounts and can login
- [x] Users can propose songs for the week's playlist
- [x] Users can spend points to vote on proposed songs
- [ ] At the end of the week, the top rated song is chosen for each letter A-Z and added to a playlist; that playlist is pushed to Spotify
  x- create a model for playlist
  - create a playlist
      - update description
      - save songs to a playlist (join table!!!)
  - have it run weekly at 5 pm... to get playlist of songs

  - *send playlist with all songs to spotify (find out what data to send...)*

- [x] Users get a fixed number of points to spend at the start of each week
- [x] Users get a bonus based on how many people voted for their suggestions last week (use or loose)
- [x] Points do _not_ transfer week-to-week (use it or lose it)
- [x] Users can veto one song pick per week
- [ ] Create better front end!
- [ ] Deploy your app to Heroku

**for now have a button to generate a playlist from voted songs**
* Add an endpoint to view playlists from past week and a button to click that adds the playlist to the current user's spotify account. Top 5 songs only.
* (This will involve OAuth authentication flows.)

### Hard Mode

- [ ] [Use a background job][clockwork] to reset votes and vetoes each Friday at 5pm
- [ ] [Use a background job][clockwork] to select top songs, create playlist, send playlist/songs to spotify friday at 5pm
- [ ] Support user-uploaded [avatars][paperclip] via Paperclip and S3

## Resources

[clockwork]: https://devcenter.heroku.com/articles/clock-processes-ruby
[paperclip]: https://devcenter.heroku.com/articles/paperclip-s3

## Resources

[Blocks, Procs, and Lambdas]: (http://code.tutsplus.com/tutorials/ruby-on-rails-study-guide-blocks-procs-and-lambdas--net-29811)
