require_relative 'cell'
require_relative 'ant'
require 'singleton'

$size = 25
$queenNo = 10
$TEST = []
$nameIndex = 0
class Meadow

  include Singleton

  attr_reader :meadow
  attr_accessor :totalHills

  def initialize
    @meadow = Array.new($size){ Array.new($size){ Cell.new } }
    @queens = Array.new($queenNo){createQueen}
    @totalHills = 0
    placeFoods
    sendQueens
  end

  def placeFoods
    foodNumber = rand(10)+4
    foodNumber.times do
      @meadow[rand($size)][rand($size)].increaseFoodBy(rand(3) + 1)
    end
  end

  def createQueen

    queen = Ant.new

    def queen.createHill(member)
      index1 = rand($size)
      index2 = rand($size)
      if member[index1][index2].hill != nil
        createHill(member)
        return
      end
      names = ["Ruby", "Any", "Beekiller", "Cannibals","Runners","helo","Poly","Workers", "ITU", "BU","Noname","Delaware"]
      $nameIndex+=1
      member[index1][index2].hill = Anthill.new(index1, index2, names[$nameIndex])
    end

    return queen
  end

  def sendQueens
    @queens.each do |queen|
      queen.createHill(@meadow)
      @totalHills += 1
    end
  end

  def showLayout
    require 'pp'
    pp(@meadow)
  end

  def shuffleAnts(x,y)
    @meadow[x][y].shuffleAnts
  end

  def addAntToCell(ant,x,y)
    @meadow[x][y].addAnt(ant)
  end

  def removeAntFromCell(ant,x,y)
    @meadow[x][y].removeAnt(ant)
  end

  def getCellValues(x,y)
    @meadow[x][y].printValues
  end

  def turn
    exit if @totalHills <= 1
    @meadow.each do |sub|
      sub.each do |cell|
        cell.turn
      end
    end
    placeFoods
  end

  def startGame
    index = 0
    while @totalHills > 1
      puts "================TURN #{index}================"
      turn
      index += 1
    end
    puts "================TURN #{index}================"
    turn
  end

end

game = Meadow.instance
game.startGame
