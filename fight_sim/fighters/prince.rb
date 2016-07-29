require_relative 'fighter'
class Prince < Fighter
  def initialize(weapon = nil)
    super(weapon)
    @character = "Prince"
    @health += 30
    @healthReset = @health
    @armour += 30
    @strength += 22
    @speed += 10
  end
end

