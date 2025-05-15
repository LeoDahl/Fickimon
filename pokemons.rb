require 'uri'
require 'json'
require 'net/http'

enemies = ["squirtle", "charmander", "bulbasaur"]

class Pokemon
  attr_accessor :name, :id, :lvl, :xp, :maxhp, :hp, :abilities, :type
  def initialize(name, pokemon_id, maxhp, hp, lvl, xp)
    @id = pokemon_id
    @name = name.upcase
    @maxhp = maxhp
    @hp = hp
    @lvl = lvl
    @xp = xp
    case @name
    when "SQUIRTLE"
      @abilities = ["attack", "waterfall", "weaken"]
      @type = "water"
    when "BULBASAUR"
      @abilities = ["attack", "grassattack", "groundattack"]
      @type = "grass"
    when "CHARMANDER"
      @abilities = ["attack", "burn", "strengthen"]
      @type = "fire"
    else
      @abilities = []
      @type = "normal"
    end
  end
  def takeDamage(dmg)
    @hp = @hp - dmg
  end
  def healPokemon(health)
    @hp = @hp + health
    if @hp > @maxhp
      @hp = @maxhp
    end
  end
  def updateXp(xpEarned)
    @maxhp *= ((@xp + xpEarned) / @xp).to_i
    @xp += xpEarned
    while @xp >= 100
      @xp -= 100
      @lvl += 1
    end
  end
  def GetAbilityObjekt(ability)
    case ability
    when "GROUNDATTACK"
      return GroundAttack
    when "ATTACK"
      return Attack
    when "GRASSATTACK"
      return GrassAttack
    when "BURN"
      return Burn
    when "WATERFALL"
      return Waterfall
    when "WEAKEN"
      return Weaken
    when "STRENGTHEN"
      return Strengthen
    end
  end
end
class Abilities
  attr_accessor :type, :name, :ability, :dmg, :rounds
  def initialize(type, name, ability, dmg, rounds)
    @type = type
    @name = name 
    @ability = ability
    @dmg = dmg
    @rounds = rounds
  end
end

## Create current ability
Attack = Abilities.new("Basic", "Basic Attack", "Attack", 10, nil)
GrassAttack = Abilities.new("Grass", "Grass Attack", "Attack", 20, nil)
Strengthen = Abilities.new("PowerUp", "Strengthen", "UpgradeStrength", 0, nil)
Burn = Abilities.new("Fire", "Burn", "lasting_attack", 5, 3)
Waterfall = Abilities.new("Water", "Waterfall", "Attack", 15, nil)
GroundAttack = Abilities.new("Ground", "Ground attack", "Sleep", 0, 1)
Weaken = Abilities.new("PowerDown", "Weaken", "DowngradeStrength", 0, nil)


def init()
  readline = File.readlines("Inventory_pokemon.txt")
  arr = readline[0].chomp.split(",")
  p arr
end