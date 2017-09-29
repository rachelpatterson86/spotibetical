module SongsHelper
  MAX_VOTES = 5
  UP_VOTE = 1
  DOWN_VOTE = -1

  def vote_ineligible_for_user(song)
    user_vote_for_song(song.id) || vetoed?(song)
  end

  def max_user_vote?
    user_vote_count >= 5
  end
  def user_vote_for_song(song_id)
    User.joins(votes: :song).where('songs.id' => song_id).include?(current_user)
  end

  def vetoed?(song)
    song.votes.recent_date_range.vetoed.present?
  end

  def disabled?(song)
    'fa-disabled' if vote_ineligible_for_user(song)
  end

  def remaining_votes
    MAX_VOTES - user_vote_count
  end

  def user_vote_count
    current_user.votes.recent_date_range.count
  end

  def song_vote_count(song)
    song.votes.recent_date_range.count
  end
end
