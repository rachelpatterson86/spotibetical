# spotibetical

## Description

Build a community-generated playlist sharing site.

* Read you some docs: [Asset Pipeline][assets], [Unobtrusive JS][ujs], [Tim's notes from Week 2][tim-w2]

[rspotify]: https://github.com/guilhermesad/rspotify
[spotify-api]: https://developer.spotify.com/

[assets]: http://guides.rubyonrails.org/asset_pipeline.html
[ujs]: http://edgeguides.rubyonrails.org/working_with_javascript_in_rails.html#built-in-helpers
[tim-w2]: https://github.com/tiy-atl-js-q1-2015/Notes/tree/master/Week%2002

Day 4:
* Add an endpoint to view playlists from past week and a button
  to click that adds the playlist to the current user's spotify account
  * (This will involve OAuth authentication flows.)

Day 5/6:
* Hard-mode things

## Requirements

### Normal Mode

- [x] Users have accounts and can login
- [x] Users can propose songs for the week's playlist
- [x] Users can spend points to vote on proposed songs
- [ ] At the end of the week, the top rated song is chosen for each letter A-Z and added to a playlist; that playlist is pushed to Spotify
- [x] Users get a fixed number of points to spend at the start of each week
- [x] Users get a bonus based on how many people voted for their suggestions last week (use or loose)
- [x] Points do _not_ transfer week-to-week (use it or lose it)
- [x] Users can veto one song pick per week
- [ ] Deploy your app to Heroku

### Hard Mode

- [ ] Add an admin-only section for managing user accounts
- [ ] [Use a background job][clockwork] to reset votes and vetoes each Friday at 5pm
- [ ] Support user-uploaded [avatars][paperclip] via Paperclip and S3

## Resources

[clockwork]: https://devcenter.heroku.com/articles/clock-processes-ruby
[paperclip]: https://devcenter.heroku.com/articles/paperclip-s3

##notes

## Resources

[Blocks, Procs, and Lambdas](http://code.tutsplus.com/tutorials/ruby-on-rails-study-guide-blocks-procs-and-lambdas--net-29811)

## Homework

* Add bootstrap and do some light styling of your site.
* Add a migration/model for proposed songs based on what we discussed in class.

It is encouraged for you to also try to define a controller, routes, and views to:

* Give the user a search form.
* On submitting the form, send them to a page populated with track results from `rspotify`.
* Clicking on a result creates an instance of your proposed song model and saves it in the database.
