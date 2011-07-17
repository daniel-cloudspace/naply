class User < ActiveRecord::Base
    validates_format_of :name, :with => /\A[a-z0-9]+\z/
    validates_presence_of :name
    validates_uniqueness_of :name
    validates_uniqueness_of :phonenumber

    has_many :friendships

    ##
    # Add a friend by name. Ideally, this function will try to figure 
    # out if the user has spelled the name wrong. It should insert two 
    # records into the Friendships table.
    def add_friend(name)
        # If friend does not already exist, create them without a phone number.
        friend = User.find_by_name name.downcase
        if !friend.nil? && !friend.id.nil?
            puts "Found user, #{friend.id}, creating Friendship"
            Friendship.create(:user_1_id => self.id, :user_2_id => friend.id)
        else
            friend = User.create :name => name.downcase
            if !friend.nil? && !friend.id.nil?
                puts "Found no user, created use, #{friend.id}, creating Friendship"
                Friendship.create(:user_1_id => self.id, :user_2_id => friend.id)
            else
                puts "Found no user and could not create new User."
                return false
            end
        end
    end
end
