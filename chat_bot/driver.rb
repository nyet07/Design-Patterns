require_relative "chat"
require_relative "user"

                        #           UGUR BUYUKDURAK
                        #           RUN THIS FILE TO START THE APPLICATION

if __FILE__ == $0
  aUser = User.new
  chatBot = ChatBot.new aUser
  aUser.addObserver(chatBot)

  chatBot.startChatBot
end
