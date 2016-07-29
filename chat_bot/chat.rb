require_relative 'read_file'
require_relative 'user'

                          #       UGUR BUYUKDURAK

                          #       THINGS TO NOTICE
          # STRATEGY PATTERN IS IMPLEMENTED USING LAMBDA FUNCTIONS.
          #
          # A LAMBDA FUNCTION BASED ON A RESPONSE IS CHOSEN AND RETURNED FROM "chooseStrategy" METHOD.
          #
          # "processResponse" METHOD FIRST CALLS "chooseStrategy" METHOD AND AFTER THAT IT CALLS
          # LAMBDA FUNCTION RETURNED BY "chooseStrategy" METHOD.
          #
          # INSIDE "chooseStrategy" METHOD, LAMBDA FUNCTIONS ARE DECLARED WITHIN PROC OBJECTS.
          # IT IS BECAUSE EACH PROC OBJECT CARRIES DIFFERENT LOGIC AS TO CHOOSING
          # PROPER LAMBDA FUNCTION CORRESPONDING TO RESPONSE FROM CONSOLE.
          #
          # THERE IS TEMPLATE DESIGN PATTERN BETWEEN CHAT AND CHATBOT.
          # 'processResponse' and 'chooseStrategy' are abstract methods in the base class.
          # "startChatBot" METHOD IS THE TEMPLATE METHOD.
          #
          # "ChatBot" INSTANCE IS MEANT TO BE AN OBSERVER TO USER CLASS IN "user.rb".

class Chat

  def initialize(user)
    #Reads responses into appropriate data structures.
    readFileObject = ReadFile.new
    @options, @matchWords, @botname = readFileObject.readChatterFile
    @preWrittenWords = readFileObject.readScriptFile
    @user = user
  end

  def startChatBot
    puts "Hello, my name is #{@botname}"
    @user.startDialogue(@preWrittenWords)
  end

  def update(user)
    @response = user.response
    processResponse(@response)
  end

  def processRespone
    raise 'Called Abstract Method: processResponse'
  end

  def chooseStrategy
    raise 'Called Abstract Method: chooseStrategy'
  end
end

class ChatBot < Chat

  def processResponse(response)

    strategy = chooseStrategy(response)
    strategy.call

  end

  def chooseStrategy(response)

    #It is important to downcase letters for comparisons.
    response.downcase!

    def checkIfOneWord(response)
      x = response.split
      return true if x.length == 1
      return false
    end

    x1 = Proc.new {

      index = Integer
      possibleMatches = Array.new

      @matchWords.each do |word|
        if response.include? word
          possibleMatches << word
        end
      end

      index = nil if possibleMatches.empty?

      unless possibleMatches.empty?
        longest = String.new
        length = 0
        possibleMatches.each do |match|
          if length < match.length
            longest = match
            length = match.length
          end
        end
        index = @matchWords.index(longest)
      end

      if index
        strategy = lambda {
          if response.include? @options[index][0]
            response = @options[index][1][rand(@options[index][1].length)]
            puts response
          end
        }
        return strategy
      end
    }

    x2 = Proc.new {
      if response.include? "?"
        return lambda {
          puts "Interesting, tell me what you think first."
        }
      end
    }

    x3 = Proc.new {
      if checkIfOneWord(response)
        return lambda {
          puts "It was really nice meeting with you. Take care of yourself. Goodbye!"
          exit
        }
      end
    }

    x4 = Proc.new {
      index = @matchWords.index "change subject"
      return lambda {
        puts @options[index][1][rand(@options[index][1].length)]
      }
    }

    x1.call
    x2.call
    x3.call
    x4.call

  end
end