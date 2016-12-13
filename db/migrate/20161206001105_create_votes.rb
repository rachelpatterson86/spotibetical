class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :song
      t.integer :score

      t.timestamps
    end
  end
end
