require_relative 'pokemons.rb'

Pokemons = File.readlines("Inventory_pokemon.txt")
Ascii = File.readlines("ascii.txt")

def initFight(pokemon)
  puts pokemon + " wishes to fight!"
  puts "Please select pokemon to fight with!"
  showpokemons()
  puts "write the number of the pokemon or name. example: '1' or 'bulbasaur'"
  youPokemon = choosePokemon()
  fight(pokemon, yourPokemon)
end

def showpokemons()
  i = 0
  while i < Pokemons.length
    Pokemons[i] = Pokemons[i].split(",")
    print "#{i+1}. "
    puts Pokemons[i][0]
    i += 1
  end
end

def choosePokemon(pokemonOfChoice)

  if pokemonOfChoice == pokemonOfChoice.to_i.to_s
    pokemonOfChoice = pokemonOfChoice.to_i
    if Pokemons[pokemonOfChoice-1] != nil
      return pokemonOfChoice-1
    end
  elsif pokemonOfChoice == pokemonOfChoice.to_f.to_s
    puts "Inga decimaler är tillåtna"
  else
    return nameMatch(pokemonOfChoice)
  end
end

def nameMatch(nameGiven) ## Hjälp funktion för choosePokemon()
  nameGiven = nameGiven.upcase
  i = 0
  while i < Pokemons.length
    u = 0
    if nameGiven.length == Pokemons[i][0].length
      while Pokemons[i][0][u] == nameGiven[u]
        if u == nameGiven.length-1
          return i
        end
        u += 1
      end
    end
    i += 1
  end
  puts "could not find the a pokemon with the name of: '#{nameGiven}'"
end


def showGUI(pokemon)
  ## Step 1, find pikachu (or corresponding pokemon)
  i = 0
  start = 0 
  endpos = 0
  while i < Ascii.length
    i = i + 1
    if Ascii[i] && Ascii[i].chomp == pokemon 
      start = i+1
      endpos = start+1
      while Ascii[endpos].chomp != "end"
        endpos = endpos + 1
      end   
    break
    end
    
  end
  z = start
    while z != endpos
      puts Ascii[z]
      z = z + 1
    end
  return start, endpos
end

def fight(enemy, allyPokemon)
  allyPokemon = Pokemon.new(Pokemons[allyPokemon])
  puts allyPokemon
  enemyLvl = allyPokemon.lvl + rand(-2..2)
  enemyMaxhp = rand(50..300)
  enemy = Pokemon.new(enemy, 1, enemyMaxhp, enemyMaxhp, enemyLvl, 0)
end



