class Vote < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :song_id

  scope :vetoed, -> { where(score: 0) }
  scope :last_7_days, -> { where(created_at: 7.days.ago..Time.current) }

  def self.current_week_tally
    Vote.last_7_days
      .where.not(song_id: vetoed.pluck(:song_id))
      .joins(:song)
      .group(:song_id, :title)
      .having('sum(score) > 0')
      .sum(:score)
  end
end
