require_relative 'pokemons.rb'

Pokemons = File.readlines("Inventory_pokemon.txt")

i = 0
# This will split the lines in the file into an array of arrays
while i < Pokemons.length
  Pokemons[i] = Pokemons[i].split(",")
  i += 1
end

Ascii = File.readlines("ascii.txt")

# Description: This prepares the battle system for the player. It will create an enemy pokemon and start the fight through the fight function
# Argument: String - the name of the enemy pokemon
# Returns: None
# Example: initFight("squirtle") will create a squirtle enemy and start the fight

def initFight(enemyPokemon)
  puts enemyPokemon + " wishes to fight!"
  yourPokemonIndex = nil
  while yourPokemonIndex == nil
    puts "Please select pokemon to fight with!"
    showpokemons()
    puts "write the number of the pokemon or name. example: '1' or 'bulbasaur'"
    pokemon_choice = gets.chomp
    yourPokemonIndex = choosePokemon(pokemon_choice)
  end
  p Pokemons[yourPokemonIndex]
  pokemonArray = Pokemons[yourPokemonIndex][0].chomp.split(",")
  yourPokemon = Pokemon.new(pokemonArray[0], pokemonArray[1].to_i, pokemonArray[2].to_i, pokemonArray[3].to_i, pokemonArray[4].to_i, pokemonArray[5].to_i)
  puts yourPokemon
  enemyLvl = yourPokemon.lvl + rand(-2..2)
  if enemyLvl < 1
    enemyLvl = 1
  end
  enemyMaxhp = rand(50..300)
  enemyPokemon = Pokemon.new(enemyPokemon, 1, enemyMaxhp, enemyMaxhp, enemyLvl, 0)
  fight(enemyPokemon, yourPokemon)
end

# Description: This function handles the fight between the player and the enemy
# Argument: Pokemon - the enemy pokemon
# Argument: Pokemon - the player pokemon
# Returns: None
def fight(enemy, ally)
  inFight = true
  allyMoves = availableMoves(ally)
  enemyMoves = availableMoves(enemy)
  while inFight
    puts "Choose your move"
    puts allyMoves
    choosenMove = gets.chomp
  end
end

# Description: This function shows the available pokemons in the players inventory
def showpokemons()
  i = 0
  while i < Pokemons.length
    print "#{i+1}. "
    puts Pokemons[i][0]
    i += 1
  end
end

# Description: This function validates the input from the player and runs the nameMatch function if the input is not a number
# Argument: String - the name or index of the pokemon
# Returns: Integer - the index of the pokemon in the Pokemons array
# Example: choosePokemon("1") returns 0
# Example: choosePokemon("bulbasaur") returns 0 if bulbasaur is the first pokemon in the Pokemons array
# Example: choosePokemon("daddafefs") returns nil if no matching pokemon is found
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

# Description: This function is an help function to the choosePokemon function and looks for a matching pokemon name in the Pokemons array
# Argument: String - the name of the pokemon given by the player
# Returns: Integer - the index of the pokemon in the Pokemons array
# Example: nameMatch("bulbasaur") returns 0 if bulbasaur is the first pokemon in the Pokemons array
# Example: choosePokemon("daddafefs") returns nil if no matching pokemon is found
def nameMatch(nameGiven) 
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
  return nil
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

# Description: This function returns the available moves for the given pokemon
# Argument: objekt - the pokemon which moves should be returned
# Returns: Array - the available moves for the given pokemon depending on the level
# Example: availableMoves(charmander) returns ["attack", "burn", "strengthen"]
# Example: availableMoves(bulbasaur) returns ["attack", "grassattack", "groundattack"]
def availableMoves(pokemon)
  lvl = pokemon.lvl
  abilities = pokemon.abilities
  p abilities
  moves = [abilities[0]]
  if lvl >= 2
    moves <<  abilities[1]
    if lvl >= 3
      moves << abilities[2] 
    end
  end
  return moves
end

initFight("squirtle")