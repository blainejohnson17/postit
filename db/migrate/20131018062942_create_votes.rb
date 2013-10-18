class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id, :voteable_type, :voteable_id

      t.timestamps
    end
  end
end
