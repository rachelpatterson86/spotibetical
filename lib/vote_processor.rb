class VoteProcessor
  UP = 1
  DOWN = -1

  attr_accessor :user, :song
  def initialize(user, song)
    @user = user
    @song = song
  end

  def vote(score)
    return unless vote_eligible?
    Vote.create(user: @user, song: @song, user_vote: score )
  end

  def veto
    return unless vote_eligible?
    Vote.create(user: @user, song: @song, user_vote: 0 )
    @user.vetoed
  end

  private
  def vote_eligible?
    @user.at_vote_limit? && can_veto?
  end

  def can_veto?
    @song.votes.where(user_vote: 0).blank? && !@user.veto
  end
end
