class Weapon
  #Weapons do not change health or chance state. Those are dependent on the particular character
  attr_reader :weapon, :armour, :strength, :speed
  def useWeapon(fighter)
    fighter.armour += @armour
    fighter.strength += @strength
    fighter.speed += @speed
  end
end



