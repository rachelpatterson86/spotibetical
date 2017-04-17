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
- [x] Users get a fixed number of points to spend at the start of each week
- [x] Users get a bonus based on how many people voted for their suggestions last week (use or loose)
- [x] Points do _not_ transfer week-to-week (use it or lose it)
- [x] Users can veto one song pick per week
- [x] Add top rated song for each letter A-Z for the week to a playlist

- [ ] Add a view to show all playlists. send to spotfy button to your own spotify acct.
- [ ] Push that playlist to a user's Spotify
  - https://github.com/guilhermesad/rspotify#rails--oauth
  X- find out what's need to push the songs onto spotify
  x- Add link to sign into Spotify (allow users to push playlist to Spotify.)
  x- possibly link spotify stuff with devise? **Remove devise?**

  x users#spotify: create test to log into spotify
  x- SendPlaylistToSpotify: create tests to push playlist to spotify!

  - if a playlist is present, allow for them to upload it! need a playlist page with a list of playlist!
    - Add to Spotify button on each available playlist!

- [ ] Create better front end!
- [ ] Deploy your app to Heroku

**for now have a button to generate a playlist from voted songs**
* Add an endpoint to view playlists from past week and a button to click that adds the playlist to the current user's spotify account.
* (This will involve OAuth authentication flows.)

### Hard Mode
* Use a background job:
- [ ] to reset votes and vetoes each Friday at 5pm
- [ ] to select top songs, create playlist, send playlist with songs to spotify friday at 5pm
  * have jobs run weekly at 5 pm *

* Use uploads:
- [ ] [avatars][paperclip] via Paperclip and S3

## Resources

[paperclip]: https://devcenter.heroku.com/articles/paperclip-s3
[Blocks, Procs, and Lambdas]: (http://code.tutsplus.com/tutorials/ruby-on-rails-study-guide-blocks-procs-and-lambdas--net-29811)
