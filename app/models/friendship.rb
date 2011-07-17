class Friendship < ActiveRecord::Base
    after_destroy :destroy_conjugate_friendship

    def destroy_conjugate_friendship
        conjugate_friendship = Friendship.find(:user1_id => self.user2_id, :user2_id => self.user1_id)
        conjugate_friendship.destroy
    end
end
