require_relative 'weapon'
class Shield < Weapon
  def initialize
    @weapon = "Shield"
    @armour=20
    @strength=5
    @speed = -10
  end
end