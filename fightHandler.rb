require_relative 'pokemons.rb'

Pokemons = File.readlines("Inventory_pokemon.txt")

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
  showGUI(enemyPokemon.upcase)
  yourPokemonIndex = nil
  while yourPokemonIndex == nil 
    puts "Please select pokemon to fight with!"
    showpokemons() ## SHOW POKEMONS
    puts "write the number or name of the pokemon. example: '1' or 'bulbasaur'" 
    pokemon_choice = gets.chomp 
    yourPokemonIndex = choosePokemon(pokemon_choice) 
  end
  pokemonArray = Pokemons[yourPokemonIndex] 
  yourPokemon = Pokemon.new(pokemonArray[0], pokemonArray[1].to_i, pokemonArray[2].to_i, pokemonArray[3].to_i, pokemonArray[4].to_i, pokemonArray[5].to_i) 
  ## Create pokemon object
  showGUI(pokemonArray[0].upcase)
  enemyLvl = rand(1..5) 
  if enemyLvl > 2 
    enemyMaxhp = rand(120..300) 
  else 
    enemyMaxhp = rand(50..200) 
  end
  enemyPokemon = Pokemon.new(enemyPokemon, 1, enemyLvl, 0, enemyMaxhp, enemyMaxhp) ## Create enemy pokemon object
  puts "You are fighting against a level #{enemyPokemon.level} #{enemyPokemon.name}!" ## Show enemy pokemon
  puts "You have a level #{yourPokemon.level} #{yourPokemon.name}!" ## Show your pokemon
  fight(enemyPokemon, yourPokemon) ## Start fight
end

# Description: This function handles the fight between the player and the enemy
# Argument 1: Objekt - the enemy pokemon
# Argument 2: Objekt - the player pokemon
# Returns: None
# Example: Pokemon.new("CHARMANDER, 1, 1, 1, 1, 1")
def fight(enemy, ally) # LUCAS
  inFight = true
  allyMoves = availableMoves(ally) # All moves as an array for ally
  allyMoves << "Capture" 
  enemyMoves = availableMoves(enemy) # All moves for enemy
  allyMult = calcDmgMult(ally.level.to_i) # Mult depending on lvl
  enemyMult = calcDmgMult(enemy.level.to_i)
  while inFight
    attack = nil
    while attack == nil
      puts "Choose your action against #{enemy.name}!"
      moves = 0
      while moves < allyMoves.length
        puts ((1+moves).to_s + ". " + allyMoves[moves].to_s)
        moves += 1
      end
      choosenMove = gets.chomp
      attack = chooseAttack(choosenMove, allyMoves)
    end
    chosenAttack = allyMoves[attack]

    if chosenAttack == "Capture" then
      puts "You tried to capture the enemy pokemon!"
      successfull = capturePokemon(enemy)
      if successfull then
        puts "You captured the enemy pokemon!"
        break
      else
        puts "You did not capture the enemy pokemon!"
      end
    else
      ability = ally.GetAbilityObjekt(chosenAttack.upcase)
      hpBefore = enemy.hp
      allyMult, enemyMult = doActionAgainst(enemy, ability, allyMult, enemyMult)
      puts "You dealt: #{hpBefore - enemy.hp} dmg!"
      ## Check if enemy has fainted
      if enemy.hp <= 0
        newxp = (enemy.maxhp)/2
        puts "#{enemy.name} has fainted! You win!"
        puts "You gained #{newxp} xp!"
        break
      else
        puts "Enemy #{enemy.name} now has #{enemy.hp} hp"
      end
    end
    puts "--------------------------------------"
    puts "press 'ENTER' to continue"
    gets.chomp
    ## Enemy turn

    chosenAttack = enemyMoves[rand(0..enemyMoves.length-1)]
    ability = enemy.GetAbilityObjekt(chosenAttack.upcase)
    hpBefore = ally.hp
    enemyMult, allyMult = doActionAgainst(ally, ability, enemyMult, allyMult)
    if ally.hp <= 0
      puts "your #{ally.name} has fainted! You lose!"
      break
    end
    puts "Enemy #{enemy.name} used #{chosenAttack}!"
    puts "You took: #{(hpBefore - ally.hp)} dmg!"
    puts "Current hp: #{ally.hp}"
    puts "--------------------------------------"
    puts "press 'ENTER' to continue"
    gets.chomp
  end
end

# Description: This function does dmg to the reciever depending on its type, ability used and the attacker damage multiplier. It could also increase the attacker's damage multiplier or decrease the reciever's damage multiplier.
# Argument 1: Objekt - Either the enemy or the player's pokemon
# Argument 2: Objekt - The ability used
# Argument 3: Float - The damage multiplier of the pokemon attacking
# Argument 4: Float - The damage multiplier of the pokemon being attacked
# Returns: Array - an array of the updated attackerMult and recieverMult
# Example: enemy_pokemon.type = "grass" doActionAgainst(enemy_pokemon, Attack, 1.2, 1.0) # => Deals 12 damage to enemy_pokemon
# Example: enemy_pokemon.type = "water" doActionAgainst(enemy_pokemon, GrassAttack, 1.0, 1.0) # => Deals 14 damage (badTypeMult applied)
# Example: enemy_pokemon.type = "grass" # => doActionAgainst(enemy_pokemon, Burn, 1.0, 1.0) # => Deals 21 damage (counterTypeMult applied)
# Example: doActionAgainst(enemy_pokemon, Weaken, 1.0, 1.0) # => recieverMult becomes 0.8 (lowers enemy's damage multiplier)
# Example: doActionAgainst(enemy_pokemon, Strengthen, 1.0, 1.0) # => attackerMult becomes 1.2 (raises user's damage multiplier)
def doActionAgainst(reciever, move, attackerMult, recieverMult) # LEO
  dmg = 0
  counterTypeMult = 1.4
  badTypeMult = 0.7
  case move.name
    when "Basic Attack" 
      dmg = (Attack.dmg * attackerMult).round(0)
      reciever.takeDamage(dmg)   
    when "Ground attack" 
      dmg = reciever.takeDamage((GroundAttack.dmg * attackerMult).round(0))
    when "Grass Attack"    ## Grass attack counters water & fire?
      dmg = GrassAttack.dmg * attackerMult
      if reciever.type == "water"
        puts "It was super effective!"
        reciever.takeDamage((dmg * counterTypeMult).round(0))
      elsif reciever.type == "fire"
        puts "It was not very effective.."
        reciever.takeDamage((dmg * badTypeMult).round(0))
      else
        reciever.takeDamage(dmg)
      end
    when "Burn"
      dmg = Waterfall.dmg * attackerMult
      if reciever.type == "grass"
        puts "It was super effective!"
        reciever.takeDamage((dmg * counterTypeMult).round(0))
      elsif reciever.type == "water"
        reciever.takeDamage((dmg * badTypeMult).round(0))
        puts "It was not very effective.."
      else
        reciever.takeDamage(dmg)
      end            
    when "Waterfall"
      dmg = Waterfall.dmg * attackerMult
      if reciever.type == "fire"
        reciever.takeDamage((dmg * counterTypeMult).round(0))
        puts "It was super effective!"
      elsif reciever.type == "grass"
        reciever.takeDamage((dmg * badTypeMult).round(0))
        puts "It was not very effective.."
      else
        reciever.takeDamage(dmg)
      end       
    when "Weaken"
      recieverMult *= 0.8          
    when "Strengthen"  
      attackerMult *= 1.2    
    end
    return [attackerMult, recieverMult]
end

# Description: This function calculates the damage multiplier depending on what lvl the pokemon is
# Argument: int - The lvl of the pokemon
# Returns: float or int - The damage multiplier of the pokemon
# Example: calcFmgMult(1) returns 1
# Example: calcFmgMult(2) returns 1.2
# Example: calcFmgMult(3) returns 1.4
def calcDmgMult(pokemonLvl) # LUCAS
  mult = 1
  mult += (pokemonLvl-1) * 0.2
  return mult
end

# Description: This function shows the available pokemons in the players inventory
# Argument: None
# Returns: None
# Example: showpokemons() shows the available pokemons in the players inventory from the Inventory_pokemon.txt file
def showpokemons() # LEO
  i = 0
  while i < Pokemons.length
    puts "#{i+1}. #{Pokemons[i][0]} lvl.#{Pokemons[i][2]}"
    i += 1
  end
end

# Description: This function validates the input from the player and runs the nameMatch function if the input is not a number
# Argument: String - the name or index of the pokemon
# Returns: Integer - the index of the pokemon in the Pokemons array
# Example: choosePokemon("1") returns 0
# Example: choosePokemon("bulbasaur") returns 0 if bulbasaur is the first pokemon in the Pokemons array
# Example: choosePokemon("daddafefs") returns nil if no matching pokemon is found
def choosePokemon(pokemonOfChoice) # LUCAS
  if pokemonOfChoice == pokemonOfChoice.to_i.to_s
    pokemonOfChoice = pokemonOfChoice.to_i
    if Pokemons[pokemonOfChoice-1] != nil
      return pokemonOfChoice-1
    else
      puts "You do not have a pokemon with that index"
    end
  elsif pokemonOfChoice == pokemonOfChoice.to_f.to_s
    puts "No decimals allowed"
  else
    return nameMatch(pokemonOfChoice)
  end
end
## Same but attacks
# Argument 1: String - the name or index of the action
# Argument 2: Array - the array of moves that the ally has
def chooseAttack(attackofChoice, allyMoves) # LUCAS
  if attackofChoice == attackofChoice.to_i.to_s
    attackofChoice = attackofChoice.to_i
    if allyMoves[attackofChoice-1] != nil
      return attackofChoice-1
    else
        puts "You do not have a pokemon with that index"
    end
  elsif attackofChoice == attackofChoice.to_f.to_s
    puts "No decimals allowed"
  else
    return attackMatch(attackofChoice, allyMoves)
  end
end

# Description: This function is an help function to the choosePokemon function and looks for a matching pokemon name in the Pokemons array
# Argument: String - the name of the pokemon given by the player
# Returns: Integer - the index of the pokemon in the Pokemons array
# Example: nameMatch("bulbasaur") returns 0 if bulbasaur is the first pokemon in the Pokemons array
# Example: choosePokemon("bulasdefsdf") asks the player if they meant a similar name, in this case bulbasaur, and returns the index of that pokemon if the player answers "yes" else nil
def nameMatch(nameGiven) # LUCAS
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
# Description: This function is an help function to the chooseAttack function and looks for a matching attack name in the allyMoves array
# Argument: String - the name of the attack given by the player
# Argument: Array - the array of moves that the ally has
# Returns: Integer - the index of the attack in the allyMoves array
# Example: attackMatch("attack") returns 0 if attack is the first move in the allyMoves array
def attackMatch(attackGiven, allyMoves) # LUCAS
  puts "attackMatch"
  nameGiven = attackGiven.upcase
  p allyMoves
  i = 0
  bestMatch = 0
  bestMatchIndex = nil
  while i < allyMoves.length
    u = 0
    matches = 0
    while u < allyMoves[i][0].length
      if attackGiven[u] == allyMoves[i][0][u]
        matches += 1
      end
      u += 1
    end
    puts "matches: #{matches}"
    if matches == allyMoves[i][0].length
      return i
    end
    if matches >= bestMatch
      bestMatch = matches
      bestMatchIndex = i
    end
    i += 1
  end
  puts "could not find the a pokemon with the name of: '#{nameGiven}'"
  puts "did you mean: '#{allyMoves[bestMatchIndex]}'?"
  puts "'yes' or 'no'?"
  answer = gets.chomp
  while answer != "yes" && answer != "no"
    puts "answer not valid, please try again"
    puts "did you mean: '#{allyMoves[bestMatchIndex][0]}'?"
    puts "'yes' or 'no'?"
    answer = gets.chomp
  end
  if answer == "yes"
    return bestMatchIndex
  end
  return nil
end

## Description: This function shows the ascii art of the given pokemon from the ascii.txt file
# Argument: String - the name of the pokemon
# Returns: start and endpos - the start and end position of the ascii art in the Ascii array
# Example: showGUI("Bulbasaur") shows the ascii art of pikachu
# Example: showGUI("Charmander") shows the ascii art of charmander
def showGUI(pokemon) ## LEO
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
def availableMoves(pokemon) # LEO
  lvl = pokemon.level
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
# Returns: true or false - true if the pokemon was captured, false if it was not
# Example: capturePokemons(charmander) returns true or false (Success or failure)
def capturePokemon(pokemon) # LUCAS
  i = 0
  id = 1

  captureChance = (100 - (pokemon.hp / pokemon.maxhp * 100)).round(0)
  if rand(0..100) > captureChance
    return false
  end

  while i < Pokemons.length
    if Pokemons[i][0] == pokemon.name
      puts "You already have this pokemon! Do you want to swap this pokemon with the one you have in your inventory?"
      puts "In inventory: #{Pokemons[i][0]} (lvl. #{Pokemons[i][2]}, Max HP #{Pokemons[i][4]}), New: #{pokemon.name} (lvl. #{pokemon.level}, Max HP #{pokemon.maxhp}) "
      puts "'yes' or 'no'?"
      answer = gets.chomp
      while answer != "yes" && answer != "no"
        puts "answer not valid, please try again"
        puts "You already have this pokemon! Do you want to swap this pokemon with the one you have in your inventory?"
        puts "in inventory: #{Pokemons[i][0]} (lvl. #{Pokemons[i][3]}, Max HP #{Pokemons[i][2]}), New: #{pokemon.name} (lvl. #{pokemon.level}, Max HP #{pokemon.maxhp}) "
        puts "'yes' or 'no'?"
        answer = gets.chomp
      end
      if answer == "yes"
        puts "You swapped your pokemon!"
        Pokemons[i] = [pokemon.name, id, pokemon.level, pokemon.xp, pokemon.hp, pokemon.maxhp]
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
      elsif answer == "no"
        puts "You did not swap your pokemon!"
        return false
      end
      return true
    end
    i += 1
  end
  puts "You captured a #{pokemon.name}!"
  File.open("Inventory_pokemon.txt", "a") do |file|
    file.puts "#{pokemon.name},#{id},#{pokemon.level},#{pokemon.xp},#{pokemon.hp},#{pokemon.maxhp},"
    Pokemons << [pokemon.name, id, pokemon.level, pokemon.xp, pokemon.hp, pokemon.maxhp]
  end
end

initFight("squirtle")