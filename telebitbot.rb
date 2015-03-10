require 'bundler/setup'
Bundler.require :default

# Flows of microdonations - it's delta time! - DeltaTime - 

# next step
#
# profligacy btc client
# web client
#
# Follows: github.com/makevoid/deltatime - sharing economy


puts "It's suggested to read the readme (reading the code is also suggested) before you run this program!"
puts


# telegram_rb

require 'yaml'

class TelegramRbInit
  
  def initialize
    # This will init telegram and ask for otp if mobile number is not registerd.
    Telegram.init
  end
  
  def init
    # At this point, you will be asked to provide a Telephone number and an SMS code will be sent to you.
    # This will be done only ONCE when you first init. The next time init will pick up your configuration
    # from the files saved in .telegram folder.
    
    # Fetch your contacts (this sometimes fails :D, but the effort of writing the bridge/library is notable!) - TODO: make a pr to delete this
    Telegram.contact_list
    
    # Send message
    users = Telegram.contact_list
  end
  
end

TelegramRbInit.new.init!



USER_NAMES     = users.map &:name
SELECTED_USERS = USER_NAMES - ["TeleBit_Sender", "Telegram", "Ricarica"]






def spam
  puts "---"
  puts "ME:"
  puts ME.to_yaml
  puts "---"
  puts "Telebit:"
  puts TELEBIT.to_yaml
  puts "---"
end

def spam_config
  # MY_NUMBER = ENV["MY_PHONE_NUMBER"] || File.read(File.expand_path "~/.my_phone_number").strip
  # ME = users.find{|user| user.phone == MY_NUMBER} # makevoid
  TELEBIT = users.find{|user| user.phone == "17604862777" }  # telebit
end

spam_config()
spam()



def send(message)
  Telegram.send_message TELEBIT.to_peer, message
end

def send_btc(user:, amount:)
  send "@#{user} #{amount}"
end


def infos
  puts
  puts "Selected users: "
  puts SELECTED_USERS.size
  puts
  
  BALANCE = 0.065
  
  BTC_PER_USER = BALANCE / SELECTED_USERS.size
  
  puts "BTC per user: "
  puts BTC_PER_USER
  puts
end

infos()


########

CUSTOM_MESSAGE  = "this is an automated message of a 'spread' donation - I've sent you some mBTC trough github.com/makevoid/telebitbot open source project (and Telegram's Telebit bot) - send @telebit a message like 'help' or 'new address' to interact with your bitcoin wallet - feel free to say hi or ask for more infos :)"
CUSTOM_MESSAGE2 = "here are some mBTC sent via telegram and teletipbot, I was testing if this thing is working and I sent some donations to most of my contacts to spread some love/mBTCs around, if you liked the idea, this is the (alpha) project github.com/makevoid/telebitbot"

########



def f(float)
  "%05.8f" % float
end

class Numeric
  def ff
    "%05.8f" % self
  end
end

# send_btc user: "antani", amount: 0.000001.ff
# send_btc user: "antani", amount: 0.00000001.ff

# exit
SELECTED_USERS.map do |name|
    # puts "#{name} - Hi #{name}, #{[CUSTOM_MESSAGE, CUSTOM_MESSAGE2].shuffle.first}"
    send_btc user: name, amount: BTC_PER_USER.ff
    # send_btc user: "antani", amount: BTC_PER_USER.ff
end

