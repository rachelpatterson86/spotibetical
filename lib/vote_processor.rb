class VoteProcessor
  UP = 1
  DOWN = -1
  VOTE_LIMIT = 5

  attr_accessor :user, :song
  def initialize(user, song)
    @user = user
    @song = song
  end

  def vote(score)
    return unless vote_eligible?
    Vote.create(user: @user, song: @song, score: score )
    add_bonus if score == UP
    remove_bonus
  end

  def veto
    return unless vote_eligible?
    Vote.create(user: @user, song: @song, score: 0 )
    @user.vetoed
  end

  def add_bonus
    return unless @song.votes.where(score: 1).count % 3 == 0
    @song.user.user_vote.increment!(:bonus_votes)
  end

  def remove_bonus
    return if @user.user_vote.bonus_votes.to_i.zero?
    @user.user_vote.decrement!(:bonus_votes)
  end

  def remaining_votes
    (VOTE_LIMIT + @user.user_vote.bonus_votes.to_i) - @user.used_votes.count
  end

  private
  def vote_eligible?
    at_vote_limit? && can_veto?
  end

  def at_vote_limit?
    @user.used_votes.count < (VOTE_LIMIT + @user.user_vote.bonus_votes.to_i)
  end

  def can_veto?
    @song.votes.where(score: 0).blank? && !@user.user_vote.veto
  end
end
