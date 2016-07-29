require_relative 'ant'
require_relative 'anthill'

class Cell

  attr_accessor :hill, :food, :ants

  def initialize
    @hill = nil
    @food = 0
    @ants = Array.new
  end

  def increaseFoodBy(value)
    @food += value
  end

  def addAnt(ant)
    @ants << ant
  end

  def shuffleAnts
    @ants.shuffle
  end

  def removeAnt(ant)
    if @ants.include? ant
      @ants.delete(ant)
    end
  end

  def printHill
    puts "Anthill Name: #{@hill.name}"
    puts "Forager Ants: #{@hill.numberOfForegers}"
    puts "Warrior Ants: #{@hill.numberOfWarriors}"
    puts "Ant Kills: #{@hill.antKills}"
    puts "Colony Kills: #{@hill.colonyKills}"
    puts "--------------------------"
  end

  def turn
    if not @hill.nil?
      @hill.createAnts #Create all the ants and add them to current cell.
      printHill
    end
    internalTurn if not @ants.empty?
  end

  def hillExist
    @ants.each do |ant|
      @ants.delete(ant) if ant.anthill.nil?
    end
  end

  def internalTurn
    hillExist #If particular hill is destroyed, this function deletes all ants from the hill.
    shuffleAnts #Randomize ants.
    ant = @ants[0]
    if ant.type == :warrior  #Type is Warrior
      warriorAnt(ant)
    else  #Type is foreger.
      foregerAnt(ant)
    end

    moveAnts
  end

  def warriorAnt(ant)
    @ants.each do |opponent|
      ant.kill(opponent)
    end
    if not @hill.nil?
      if rand(5) == 0
        @hill = nil
        ant.destroyHill(@hill)
      else
        @ants.delete(ant)
      end
    end
  end

  def foregerAnt(ant)
    ant.obtainFood
    @ants.each do |ant|
      if ant.type == :warrior
        warriorAnt(ant)
        return
      end
    end
  end

  def moveAnts
    @ants.each do |ant|
      ant.move
    end
  end

end