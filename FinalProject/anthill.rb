require_relative 'ant'

class Anthill

  attr_accessor :numberOfForegers, :numberOfWarriors, :antKills, :colonyKills, :food,:name

  def initialize(x,y,name)
    @food = 5
@name = name

    @numberOfWarriors = 0
    @numberOfForegers = 0
    @antKills = 0
    @colonyKills = 0

    @xAxis = x
    @yAxis = y
  end

  def createAnt

    basicAnt = Ant.new

    basicAnt.x = @xAxis
    basicAnt.y = @yAxis
    basicAnt.anthill = self

    if rand(2) == 1
      basicAnt = createForager(basicAnt)
    else
      basicAnt = createWarrior(basicAnt)
    end

    Meadow.instance.addAntToCell(basicAnt, @xAxis, @yAxis)
    @food -= 1 #Decresae food by one for a new ant.
  end

  def createAnts
    while @food > 0
      createAnt
    end
  end

  def createForager(ant)
    ant.type = :forager
    def ant.obtainFood
      meadow = Meadow.instance
      @anthill.food += meadow.meadow[@x][@y].food
      meadow.meadow[@x][@y].food = 0
    end

    @numberOfForegers += 1
    ant
  end

  def createWarrior(ant)
    ant.type = :warrior

    def ant.kill(opponent)
      meadow = Meadow.instance
      cell = meadow.meadow[@x][@y]

      if opponent.anthill != @anthill && opponent != self

        if opponent.type == :Warrior
          opponent.anthill.numberOfWarriors -= 1
        else
          opponent.anthill.numberOfForegers -= 1
        end

        cell.ants.delete(opponent)
        @anthill.antKills += 1

      end

    end

    def ant.destroyHill(hill)
      if hill != @anthill

        Meadow.instance.totalHills -= 1 #To end the game.
        @anthill.colonyKills += 1
        hill = nil #hill is destroyed.

      end
    end

    @numberOfWarriors += 1
    ant
  end
end








