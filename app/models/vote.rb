class Vote < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :song_id

  scope :voted, -> { where.not(score: 0) }
  scope :vetoed, -> { where(score: 0) }
  scope :recent_date_range, -> { where(created_at: eligible_date_range ) }
  scope :last_7_days, -> { where(created_at: 7.days.ago..Time.current) }

  def self.for_user_or_song(user, song)
    where(user: user, song: song).where_values.inject(:or)
  end

  private

  def self.eligible_date_range
    Date.current.last_friday...Date.tomorrow
  end
end
