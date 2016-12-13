class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id, index: true
      t.integer :bonus_votes
      t.boolean :veto, default: false

      t.timestamps
    end
  end
end
