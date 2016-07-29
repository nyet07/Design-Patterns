require_relative 'fighter'
class Knight < Fighter
  def initialize(weapon = nil)
    super(weapon)
    @character = "Knight"
    @health += 40
    @healthReset = @health
    @armour += 45
    @strength += 40
    @speed += -34
  end
end

