class AddUserVoteToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_vote, :integer
  end
end
