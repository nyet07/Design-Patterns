require_relative '../weapons/weapon'
class Fighter

  attr_accessor :health, :armour, :strength, :speed
  attr_reader :character, :weapon

  def initialize(weapon)
    #Everything will be evaluated out of hundred. This means maximum possible value is one hundred for each attribute.
    @health = Float(50)
    @armour = Float(50)
    @strength = Float(50)
    @speed = Float(50)
    @weapon = weapon    #Subclasses will initialize weapon as nil in case that no weapon is provided.

    setWeapon(weapon)
  end

  def fight(character)
    #In case that if damage absorbed is greater than damage given.
    #in this case netDamage is set to 0 and absorbed damage is set to damage given by opponent.
    damageToBeAbsorbed = character._damageToBeAbsorbed
    netDamage = calculateDamage - damageToBeAbsorbed
    netDamage = 0 if netDamage < 0
    damageToBeAbsorbed = calculateDamage if netDamage < 0

    puts "#{character.character} took #{calculateDamage.round(2)} and #{damageToBeAbsorbed.round(2)} of damage is absorbed by the armour"
    character.health -= netDamage
    puts "#{character.character}'s remaining health is : #{character.health.round(2)}"
    sleep(waitTime)  #Waits for amount of time return by waitTime func which is dependent on @speed attribute
  end

  def setWeapon(weapon = nil)
    @weapon = weapon    #Weapons change state of strength, armour and speed, chance and health are dependent on the character
    #If fighter has a weapon, he uses it.
    if weapon
      weapon.useWeapon(self)
    end
  end

  #Used for calculating wait times when fighting.
  def waitTime
     #Wait time and @speed attribute are inversely proportional. More speed means less wait time.
     return 50 / @speed
  end

  #Used for calculating damage to absorbed by a Armour.
  def _damageToBeAbsorbed
    #Armour and absorbed damage are directly proportional.
    return @armour / (rand(16) + 40)   #Armour can be divided by values that ranges between 40 and 55
  end                                #This means that damage absorbed by the armour will be different each time.

  def calculateDamage
                                                #Each character has their own chance value that affects their amount of damage time to time.
    randomness = case @character                #These values are used for giving a chance interval for every character.
                   when "King" then rand 10     #King has 5 / 10 probability to hit 3X more
                   when "Queen" then rand 13    #Queen has 8 / 13 probability to hit 3X more
                   when "Knight" then rand 8    #Knight has 3 / 8 probability to hit 3X more
                   when "Prince" then rand 9    #Prince has 4 / 9 probability to hit 3X more
                   when "Troll" then rand 7     #Troll has 2 / 7 probability to hit 3X more
                 end
    rawDamage = Float(@strength / 37)
    rawDamage *= 3 if randomness >= 5           #Random values are checked against value of 5.
    puts "#{@character} got chance to hit with 3X more damage! Now your damage is #{rawDamage.round(2)}" if randomness >= 5
    return rawDamage
  end

  def resetHealth
    #This function is used for resetting health attribute since after each fight the character loses his health attribute.
    #This function is called at the beginning of the each fight.
    @health = @healthReset
  end
end