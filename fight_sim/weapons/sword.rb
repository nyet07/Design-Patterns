require_relative 'weapon'
class Sword < Weapon
  def initialize
    @weapon = "Sword"
    @armour = 3
    @strength = 5
    @speed = -1
  end
end