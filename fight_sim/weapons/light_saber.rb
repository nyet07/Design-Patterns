require_relative 'weapon'
class LightSaber < Weapon
  def initialize
    @weapon = "LightSaber"
    @armour=5
    @strength=10
    @speed=5
  end
end