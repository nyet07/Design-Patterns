
                      #                      UGUR BUYUKDURAK

class ReadFile
  attr_reader :options, :matchWords, :preWrittenResps

  def initialize
    #It is assumed that program always include chatter.txt so there is no check.
    @file = File.new("chatter.txt", "r")
    #File2 is checked to see if script.txt file exists.
    @file2 = File.new("script.txt", "r") if File.exist?("script.txt")
    #@options is a data structure that holds both partial matches and corresponding answers.
    @options = Array.new
    #@matchWords is a data structure that only holds partial matches. Usually used to get indexes to be
    #used in @options.
    @matchWords = Array.new
    #This data structure stores pre-written sentences from script.txt If there there no
    #script.txt file provided, then it is simply return as a nil value.
    @preWrittenResps = Array.new
  end

  def readChatterFile
    partialResponse = String.new
    legitimateResp = Array.new
    responses = Array.new
    @file.each_line do |line|
      templine = line.dup
      partialResponse.clear
      legitimateResp.clear
      responses.clear
      until line.strip == ""
        semiColonIndex = line.index(";").to_i
        semiColonIndex = 1000000 if semiColonIndex == 0
        colonIndex = line.index(":").to_i
        colonIndex = 1000000 if colonIndex == 0

        if semiColonIndex > colonIndex
          partialResponse = line[0..colonIndex-1].strip
          line.slice! line[0..colonIndex]
        elsif line.include? "@"
          @botname = line[1..line.length-1]
          line = ""
        else
          legitimateResp << line[0..semiColonIndex-1].strip
          line.slice! line[0..semiColonIndex]
        end
      end
      responses << partialResponse.dup << legitimateResp.dup
      @options << responses.dup if templine.include? ":"
    end
    @file.close
    @options.each do |options|
      @matchWords << options[0].downcase
    end
    #This function return all data structures needed by
    return @options, @matchWords, @botname
  end

  def readScriptFile
    #Check if file2 is created or not. If not, simply return nil.
    #Nil value will later be used by the program to decide whether
    #it will use input from the console or input from a file.
    if File.exist?("script.txt")
      @file2.each_line do |line|
        @preWrittenResps << line
      end
      return @preWrittenResps
    else
      return nil
    end
  end
end

#To see inside of data structures and how text file is parsed
#just run this file. THIS FILE HOWEVER IS NOT MAIN PROGRAM.
if __FILE__ == $0
  instance = ReadFile.new
  instance.readChatterFile
  instance.readScriptFile
  require 'pp'
  puts "-------OPTIONS--------"
  PP.pp(instance.options)
  puts "-------MATCHWORDS-------"
  PP.pp(instance.matchWords)
  puts "-------PRE-WRITTEN INPUTS--------"
  PP.pp (instance.preWrittenResps)
end