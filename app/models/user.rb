class User < ActiveRecord::Base
    has_many :friendships

    ##
    # Add a friend by name. Ideally, this function will try to figure 
    # out if the user has spelled the name wrong. It should insert two 
    # records into the Friendships table.
    def add_friend(name)
        friend = User.find_by_name name
        if friend
            Friendship.create(:user_1_id => self.id, :user_2_id => friend.id)
        else
            return false
        end
    end
end
