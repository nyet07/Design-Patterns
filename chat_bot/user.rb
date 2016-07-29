require 'observer'
                        #                   Ugur Buyukdurak
class User
  include Observable
  attr_accessor :response

  def initialize
    @observers = []
  end

  def startDialogue(response = nil)
    while changed(true)
      getResponse(response)
      notify_observers(self)
    end
  end

  def getResponse(response)
    if response
      unless response.empty?
        @response = response[0] unless response.empty?
        puts "#{response[0]}"
      else
        print ">"
        @response = gets.chomp
      end
      response.shift
    else
      print ">"
      @response = gets.chomp
    end
  end

  def addObserver(observer)
    add_observer(observer)
  end
end