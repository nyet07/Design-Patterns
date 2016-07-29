require_relative 'anthill'

$boundry = 23

class Ant

  attr_accessor :type, :location, :anthill, :x, :y

  def initialize
    @type = :basic
    @anthill = nil
    @x = nil
    @y = nil
  end

  def move
    if rand(4) == 0
      moveUp
    elsif rand(4) == 1
      moveDown
    elsif rand(4) == 2
      moveLeft
    elsif rand(4) == 3
      moveRight
    end

  end

  def moveUp
    if @y < 1
      moveDown
      return
    end
    meadow = Meadow.instance
    meadow.removeAntFromCell(self,@x,@y)
    @y -= 1
    meadow.addAntToCell(self,@x,@y)
  end

  def moveDown
    if @y > $boundry
      moveUp
      return
    end
    meadow = Meadow.instance
    meadow.removeAntFromCell(self,@x,@y)
    @y += 1
    meadow.addAntToCell(self,@x,@y)
  end

  def moveLeft
    if @x < 1
      moveRight
      return
    end
    meadow = Meadow.instance
    meadow.removeAntFromCell(self,@x,@y)
    @x -= 1
    meadow.addAntToCell(self,@x,@y)
  end

  def moveRight
    if @x > $boundry
      moveLeft
      return
    end
    meadow = Meadow.instance
    meadow.removeAntFromCell(self,@x,@y)
    @x += 1
    meadow.addAntToCell(self,@x,@y)
  end
end
