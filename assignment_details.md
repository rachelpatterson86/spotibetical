# spotibetical

## Description

Build a community-generated playlist sharing site.

* Read you some docs: [Asset Pipeline][assets], [Unobtrusive JS][ujs], [Tim's notes from Week 2][tim-w2]

[rspotify]: https://github.com/guilhermesad/rspotify
[spotify-api]: https://developer.spotify.com/

[assets]: http://guides.rubyonrails.org/asset_pipeline.html
[ujs]: http://edgeguides.rubyonrails.org/working_with_javascript_in_rails.html#built-in-helpers
[tim-w2]: https://github.com/tiy-atl-js-q1-2015/Notes/tree/master/Week%2002

Day 2:
* Add a way for users to suggest songs that pulls track info from Spotify

Day 3:
* Add a way for users to vote suggestions for the weeks playlist up or down
* Add support for vetoing songs

Day 4:
* Add an endpoint to view playlists from past week and a button
  to click that adds the playlist to the current user's spotify account
  * (This will invole OAuth authentication flows.

Day 5/6:
* Hard-mode things

## Requirements

### Normal Mode

- [x] Users have accounts and can login
- [x] Users can propose songs for the week's playlist
- [x] Users can spend points to vote on proposed songs
- [ ] At the end of the week, the top rated song is chosen for each letter A-Z and added to a playlist; that playlist is pushed to Spotify
- [x] Users get a fixed number of points to spend at the start of each week
- [ ] Users get a bonus based on how many people voted for their suggestions last week (use or loose)
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

## Part 2: Spotify Search Things

### Data Model First!

We need some kind of table to track song suggestions.
Remember that a user has many suggestions.

** Super important!
songs:
  user_id: integer
  artist: string
  title: string # Another Painful Day, An Example, Better with Beer, Can't We Lunch, etc
  spotify_id: string, :unique => true
  t.time stamps -> created_at and updated_at

Suggesting a song that has already been suggested before ...
* If spotify_id must be unique, then we find the old suggestion
  and update it for this week. But maybe a playlist needs to know
  the old suggestion. If there's a playlist table, it probably needs
  to be able to find the suggestion.
  I **strongly believe** each time a suggestion is made, we should create
  a new song_suggestion db record.

* Store votes *on* a suggestion? How do we enforce a user
  can only vote once? Maybe we wants users to be able to
  vote for a song more than once!

* Uniqueness from index on spotify_id.
  But that carries across weeks which might be bad ...
  `add_index :songs, :spotify_id, :unique => true`

song_votes:
    `belongs_to :user`
    `belongs_to :song`

# DO NOT WORRY ABOUT DEFINING THE WHOLE DATA MODEL TONIGHT. JUST SONGS.

So, we could have some search box on our site that makes a request to Rails
and the controller could get results from Spotify's API and show the user a
results page. ... But that seems awfully crappy! Can we do better?

## Resources

[Blocks, Procs, and Lambdas](http://code.tutsplus.com/tutorials/ruby-on-rails-study-guide-blocks-procs-and-lambdas--net-29811)

## Homework

The original way suggested that you "Add a way for users to suggest songs that pulls track info from spotify."

I am amending that slightly. You should get two things done tonight:

* Add bootstrap and do some light styling of your site.
* Add a migration/model for proposed songs based on what we discussed in class.

It is encouraged for you to also try to define a controller, routes, and views to:

* Give the user a search form.
* On submitting the form, send them to a page populated with track results from `rspotify`.
* Clicking on a result creates an instance of your proposed song model and saves it in the database.

We'll discuss a good way to do this in class tomorrow (whether on campus or remote).
