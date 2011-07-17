class Friendship < ActiveRecord::Base
    after_create :create_conjugate_friendship
    after_destroy :destroy_conjugate_friendship

    def create_conjugate_friendship
        puts "CREATING FRIENDSHIP"
        if ! Friendship.find(:user_1_id => self.user_2_id, :user_2_id => self.user_1_id)
            Friendship.create(:user_1_id => self.user_2_id, :user_2_id => self.user_1_id)
        end
    end
    def destroy_conjugate_friendship
        conjugate_friendship = Friendship.find(:user_1_id => self.user_2_id, :user_2_id => self.user_1_id)
        conjugate_friendship.destroy
    end
end
