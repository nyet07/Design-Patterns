require_relative 'fighters/king'
require_relative 'fighters/knight'
require_relative 'fighters/prince'
require_relative 'fighters/queen'
require_relative 'fighters/troll'

require_relative 'weapons/gun'
require_relative 'weapons/knife'
require_relative 'weapons/light_saber'
require_relative 'weapons/shield'
require_relative 'weapons/sword'
require_relative 'weapons/axe'

class BeginFight
  #Set of weapons and characters are created and stored within an array.
  def initialize
    @weapons = [Gun.new, Knife.new, LightSaber.new, Shield.new, Sword.new, Axe.new]
    @characters = [King.new, Knight.new, Prince.new, Queen.new, Troll.new]
  end

  def startGame
    #Choosing Character
    displayCharacters
    chooseCharacter

    #Choosing weapon
    displayWeapons
    chooseWeapon

    #Prepare Fight
    prepareFight

    #This where Threads are used.
    beginFight
  end

  def finishFight(result)   #If our character loses then the game finishes.
    puts "The Game is over. #{result}"
    exit
  end

  def prepareFight    #Every character that is already chosen should move out of the array.

    @character.setWeapon @weapon

    if @characters.include? @character
      @characters.delete(@character) #Delete the character chosen from user from the array
    end

    unless @characters.empty?
      displayCharacters
      @enemy = chooseEnemy
      @enemy.setWeapon(@weapons[rand(@weapons.length)]) #This gives enemy a weapon to use.
      puts "Your opponent is: #{@enemy.character}"
      puts "His/her choice of weapon is: #{@enemy.weapon.weapon}"
      @characters.delete(@enemy)
    end
  end

  def beginFight
    #A function that determines who wins each fight
    #If our character loses then it terminates the program printing "you lost!"
    def whoWins
      finishFight("You lost!") if @character.health < 0
    end

    #If our character happens to win the fight then this function will be used later on within beginFight function
    #to start a new fight.
    def startAnotherFight
      finishFight "You won!" if @characters.empty?
      displayWeapons
      chooseWeapon
      prepareFight
      beginFight
    end

    #In case that if a character have fought before, reset his health to beginning.
    #This function sets his health to initial value.
    @character.resetHealth

    #First one whose's health is zero loses the game
    #This is the place where both characters start fighting each other.
    #There are two separate threads for both characters.
    threads=[]
    semaphore = Mutex.new
    threads << Thread.new(@character, @enemy, threads) do |character, enemy, threads|
      #Keep fighting until one passes over.
      while character.health > 0 and enemy.health > 0
        puts "------------------------------------------"
        semaphore.synchronize{
          puts "Your character: #{character.character}"
        }
        character.fight(enemy)
        puts "------------------------------------------"
      end
    end
    threads << Thread.new(@character, @enemy, threads) do |character, enemy, threads|
      #Keep fighting until one passes over.
      while character.health > 0 and enemy.health > 0
        puts "------------------------------------------"
        semaphore.synchronize{
          puts "Enemy: #{enemy.character}"
        }
        enemy.fight(character)
        puts "------------------------------------------"
      end
    end

    #Fighting code ends here.
    threads.each do |item|
      item.join
    end

    #See who the winner is
    whoWins
    #Start over if our character has won the fight.
    startAnotherFight
  end

  def displayCharacters
    index = 1
    puts "----------------"
    @characters.each do |character|
      puts "##{index} --> #{character.character}"
      puts "Health:" + character.health.to_s + "\n" +
               "Armour:" + character.armour.to_s + "\n" +
               "Strength:" + character.strength.to_s + "\n" +
               "Speed:" + character.speed.to_s
      index += 1
      puts "----------------"
    end
  end

  def displayWeapons
    index = 1
    puts "----------------"
    @weapons.each do |weapon|
      puts "##{index} --> #{weapon.weapon}"
      puts "Armour to be added:" + weapon.armour.to_s + "\n" +
               "Strength to be added:" + weapon.strength.to_s + "\n" +
               "Speed to be added:" + weapon.speed.to_s
      index += 1
      puts "----------------"
    end
  end

  def chooseCharacter
    print "Choose your character:"
    @character = case gets.chomp
                  when "1" then @characters[0]
                  when "2" then @characters[1]
                  when "3" then @characters[2]
                  when "4" then @characters[3]
                  when "5" then @characters[4]
                  else puts "You have to type correct selection option"; makeChoice;
                 end
    puts "You chose #{@character.character}"
  end

  def chooseWeapon
    print "Choose your weapon(to not choose please enter nothing):"
    @weapon = case gets.chomp
                when "1" then @weapons[0]
                when "2" then @weapons[1]
                when "3" then @weapons[2]
                when "4" then @weapons[3]
                when "5" then @weapons[4]
                when "6" then @weapons[5]
                else nil
              end
    puts "You chose #{@weapon.weapon}" if @weapon
    puts "You didn't choose any weapon." unless @weapon
  end

  def chooseEnemy
    #Input should be taken dependent on the length of the array.
    print "Choose your opponent:"
    if @characters.length == 4
      return case gets.chomp
               when "1" then @characters[0]
               when "2" then @characters[1]
               when "3" then @characters[2]
               when "4" then @characters[3]
               else puts "You have to type correct selection option"; chooseEnemy;
             end
    elsif @characters.length == 3
      return case gets.chomp
               when "1" then @characters[0]
               when "2" then @characters[1]
               when "3" then @characters[2]
               else puts "You have to type correct selection option"; chooseEnemy;
             end
    elsif @characters.length == 2
      return case gets.chomp
               when "1" then @characters[0]
               when "2" then @characters[1]
               else puts "You have to type correct selection option"; chooseEnemy;
             end
    elsif @characters.length == 1
      return case gets.chomp
               when "1" then @characters[0]
               else puts "You have to type correct selection option"; chooseEnemy;
             end
    end
  end
end

x=BeginFight.new
x.startGame