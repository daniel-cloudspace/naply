class MessagingController < ApplicationController
  def index
    text = params["session"]["initialText"]
    from = params["session"]["from"]
    network = from["network"]
    phone = from["id"]

    # if this message is an SMS message
    if network == "SMS" && phone =~ /^[0-9]+$/
      @user = User.find_by_phonenumber phone
      # if this is a new user, create a new user
      if @user.nil?
        if @user = User.create :phonenumber => phone, :name => text
          render :json => Tropo::Generator.say "#{phone} has been added. Tell people to add you as '#{text}'!"
        end
      end

      render :json => parse(initial_text)
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
