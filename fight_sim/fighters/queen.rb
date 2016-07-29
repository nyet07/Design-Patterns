require_relative 'fighter'
class Queen < Fighter
  def initialize(weapon = nil)
    super(weapon)
    @character = "Queen"
    @health += 10
    @healthReset = @health
    @armour += -10
    @strength += -20
    @speed += 45
  end
end

