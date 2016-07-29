require_relative 'weapon'
class Gun < Weapon
  def initialize
    @weapon = "Gun"
    @armour=0
    @strength=5
    @speed=5
  end
end