class Friendship < ActiveRecord::Base
    validates_uniqueness_of :user_2_id, :scope => :user_1_id

    after_create :create_conjugate_friendship
    after_destroy :destroy_conjugate_friendship

    def create_conjugate_friendship
        if ! Friendship.find_by_user_1_id_and_user_2_id(self.user_2_id, self.user_1_id)
            Friendship.create(:user_1_id => self.user_2_id, :user_2_id => self.user_1_id)
        end
    end
    def destroy_conjugate_friendship
        conjugate_friendship = Friendship.find_by_user_1_id_and_user_2_id(self.user_2_id, self.user_1_id)
        conjugate_friendship.destroy
    end
end
