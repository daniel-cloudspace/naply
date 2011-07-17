class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :user_1_id
      t.integer :user_2_id

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
