require_relative 'fighter'
class King < Fighter
  def initialize(weapon = nil)
    super(weapon)
    @character = "King"
    @health += 15
    @healthReset = @health
    @armour += 30
    @strength += 20
    @speed += 5
  end
end

