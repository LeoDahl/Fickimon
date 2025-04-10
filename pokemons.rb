require 'uri'
require 'json'
require 'net/http'

class Pokemon
  attr_accessor :name, :id, :lvl, :xp, :maxhp, :hp, 
  :effects, :effectduration, :dmgmult
  def initialize(name, pokemon_id,maxhp,hp, lvl, xp)
    @id = pokemon_id
    @effects = effects
    @name = name
    @maxhp = maxhp
    @hp = hp
    @lvl = lvl
    @xp = xp
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
  def UseAbility()
    case ability
    when "immune"
      # Do immune things
    when "attack"
      # Do attack thing
    when "lasting_attack"
      # Do lasting attack thing
    when "sleep"
      # Do stun thing
    when "weaken"
      # Do make opponent mult weaker thing
    when "strengthen"
      # Do gym gains mult thing
    when "clash"
      # Do both take the pokemon with least hp damage thing
    when "life_steal"
      # Do take hp thing
    end
  end

end

## Create current ability
GrassAttack = Abilities.new("Grass", "Grass Attack", "Attack", 20, nil)
FlyAway = Abilities.new("Flying", "Fly away", "immune", nil, 2)
Burn = Abilities.new("Fire", "Burn", "lasting_attack", 5, 3)
Waterfall = Abilities.new("Water", "Water attack", "Attack", 15, nil)
GroundAttack = Abilities.new("Ground", "Ground attack", "Sleep", 0, 2)


def init()
  readline = File.readlines("Inventory_pokemon")
  arr = readline[0].split(",")
  puts arr
end


init()