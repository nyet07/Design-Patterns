require_relative 'weapon'
class Axe < Weapon
  def initialize
    @weapon = "Axe"
    @armour=2
    @strength=5
    @speed = -4
  end
end