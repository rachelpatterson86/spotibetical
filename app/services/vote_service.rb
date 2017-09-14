class VoteService
  VETO = 0
  VOTE_LIMIT = 5

  def initialize(user, song)
    @user = user
    @song = song
  end

  def vote(score)
    return unless voting_eligible? && veto_eligible?
    Vote.create(user: user, song: song, score: score )
  end

  def veto
    return unless veto_eligible?
    Vote.create(user: user, song: song, score: VETO )
  end

  def remaining_votes
    VOTE_LIMIT - user.votes.voted.recent_date_range.count
  end

  private
  attr_reader :user, :song

  def voting_eligible?
    user.votes.voted.recent_date_range.count < VOTE_LIMIT
  end

  def veto_eligible?
    Vote.vetoed.recent_date_range.where(Vote.for_user_or_song(user, song)).blank?
  end
end
