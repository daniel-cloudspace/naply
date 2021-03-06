class MessagingController < ApplicationController
  def index
    text = params["session"]["initialText"]
    from = params["session"]["from"]
    network = from["network"]
    phone = from["id"]

    # if this message is an SMS message
    if network == "SMS" && phone =~ /^[0-9]+$/
      @user = User.find_by_phonenumber phone

      if @user.nil? # CREATE THE USER FROM THE TEXT, SOMEHOW
        @user = User.find_by_name_and_phonenumber text.downcase, nil
        if @user.nil? # CREATE THE USER COMPLETELY NEW
          @user = User.create :name => text.downcase, :phonenumber => phone
          render :json => Tropo::Generator.say("#{phone} has been added. Tell people to add you as '#{text}'!")
        else # UPDATE AN EXISTING FRIEND WHO HAD NO PHONE NUMBER (created by add_friend)
          @user.phonenumber = phone
          if @user.save
            render :json => Tropo::Generator.say("You already have friends! #{phone} has been associated. Tell people to add you as '#{text}'!")
          else 
            render :json => Tropo::Generator.say("Something has gone wrong :(. Check out the Cloudspace Booth by and we'll fix it!")
          end
        end
      else # ADD FRIENDSHIP
        # if we DID find a user, then the message is a friend-add request, and the message text is the friend's name
        if @user.add_friend(text.downcase)
          render :json => Tropo::Generator.say("Added #{text} as a friend! Go meet more people!")
        else
        end
      end
    else
      render :json => Tropo::Generator.say("Unsupported operation")
    end
  end

  private

  def parse(input)
    input.strip!
    # do whatever parsing you need.  in this example, if user types "n what a new day", tropo will
    # respond him with "you said: what a new day"
    if m = input.match(/^(n|N)\s+/)
      Tropo::Generator.say "you said: " + m.post_match
    else
      Tropo::Generator.say "Unsupported operation."
    end
  end
end
