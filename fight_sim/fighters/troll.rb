require_relative 'fighter'
class Troll < Fighter
  def initialize(weapon = nil)
    super(weapon)
    @character = "Troll"
    @health += 45
    @healthReset = @health
    @armour += 0
    @strength += 45
    @speed += -20
  end
end

