require_relative 'pokemons.rb'

Pokemons = File.readlines("Inventory_pokemon.txt")
p Pokemons

i = 0
# This will split the lines in the file into an array of arrays
while i < Pokemons.length
  Pokemons[i] = Pokemons[i].chomp.split(",")
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
    puts "write the number or name of the pokemon. example: '1' or 'bulbasaur'"
    pokemon_choice = gets.chomp
    yourPokemonIndex = choosePokemon(pokemon_choice)
  end
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
    puts "Choose your move against #{enemy.name}!"
    moves = 0
    while moves < allyMoves.length
      puts ((1+moves).to_s + " " + allyMoves[moves].to_s)
      moves += 1
    end
    choosenMove = gets.chomp
    i = 0
    while i < allyMoves.length do
      if choosenMove == allyMoves[i]
        # If move has been found in arr
        ## Find move dmg?
        ## Temp dmg
        enemy.takeDamage(10)
        puts ((enemy.hp).to_s)
        break
      end
      i += 1
    end
  end
end

# Description: This function shows the available pokemons in the players inventory
def showpokemons()
  i = 0
  while i < Pokemons.length
    puts "#{i+1}. #{Pokemons[i][0]} lvl.#{Pokemons[i][4]}"
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
# Example: choosePokemon("daddafefs") asks the player if they meant a similar name and returns the index of that pokemon if the player answers "yes" else nil
def nameMatch(nameGiven) 
  nameGiven = nameGiven.upcase
  i = 0
  bestMatch = 0
  bestMatchIndex = nil
  while i < Pokemons.length
    u = 0
    matches = 0
    while u < Pokemons[i][0].length
      if nameGiven[u] == Pokemons[i][0][u]
        matches += 1
      end
      u += 1
    end
    if matches == Pokemons[i][0].length
      return i
    end
    if matches >= bestMatch
      bestMatch = matches
      bestMatchIndex = i
    end
    i += 1
  end
  puts "could not find the a pokemon with the name of: '#{nameGiven}'"
  puts "did you mean: '#{Pokemons[bestMatchIndex][0]}'?"
  puts "'yes' or 'no'?"
  answer = gets.chomp
  while answer != "yes" && answer != "no"
    puts "answer not valid, please try again"
    puts "did you mean: '#{Pokemons[bestMatchIndex][0]}'?"
    puts "'yes' or 'no'?"
    answer = gets.chomp
  end
  if answer == "yes"
    return bestMatchIndex
  end
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
  moves = [abilities[0]]
  if lvl >= 2
    moves <<  abilities[1]
    if lvl >= 3
      moves << abilities[2] 
    end
  end
  return moves
end

# Description: This function adds a new pokemon to the inventory or offers to swap it. The function use gets.chomp to know if player wants to swap.
# Argument: objekt - The pokemon that is captured
# Returns: nil - Returns nil to end the function
# Example: capturePokemons(charmander) returns nil
def capturePokemon(pokemon)
  i = 0
  newId = 1
  while i < Pokemons.length
    if Pokemons[i][0] == pokemon.name
      puts "You already have this pokemon! Do you want to swap this pokemon with the one you have in your inventory?"
      puts "In inventory: #{Pokemons[i][0]} (lvl. #{Pokemons[i][4]}, Max HP #{Pokemons[i][2]}), New: #{pokemon.name} (lvl. #{pokemon.lvl}, Max HP #{pokemon.maxhp}) "
      puts "'yes' or 'no'?"
      answer = gets.chomp
      while answer != "yes" && answer != "no"
        puts "answer not valid, please try again"
        puts "You already have this pokemon! Do you want to swap this pokemon with the one you have in your inventory?"
        puts "in inventory: #{Pokemons[i][0]} (lvl. #{Pokemons[i][4]}, Max HP #{Pokemons[i][2]}), New: #{pokemon.name} (lvl. #{pokemon.lvl}, Max HP #{pokemon.maxhp}) "
        puts "'yes' or 'no'?"
        answer = gets.chomp
      end
      if answer == "yes"
        puts "You swapped your pokemon!"
        Pokemons[i] = [pokemon.name, newId, pokemon.maxhp, pokemon.hp, pokemon.lvl, pokemon.xp]
        File.open("Inventory_pokemon.txt", "w") do |file|
          u = 0
          while u < Pokemons.length
            j = 0
            while j < Pokemons[u].length
              file.print "#{Pokemons[u][j]},"
              j += 1
            end
            file.print "\n"
            u += 1
          end
        end
      end
      return nil
    end
    i += 1
  end
  puts "You captured a #{pokemon.name}!"
  File.open("Inventory_pokemon.txt", "a") do |file|
    file.puts "#{pokemon.name},#{newId},#{pokemon.maxhp},#{pokemon.hp},#{pokemon.lvl},#{pokemon.xp},"
    Pokemons << [pokemon.name, newId, pokemon.maxhp, pokemon.hp, pokemon.lvl, pokemon.xp]
  end
end

capturePokemon(Pokemon.new("SQUIRTLE","2","12","2","1","0"))
initFight("squirtle")