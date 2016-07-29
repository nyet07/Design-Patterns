require_relative 'weapon'
class Knife < Weapon
  def initialize
    @weapon = "Knife"
    @armour=0
    @strength=2
    @speed=5
  end
end