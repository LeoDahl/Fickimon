Pokemons = File.readlines("Inventory_pokemon.txt")

def startFight(pokemon)
  puts pokemon + " wishes to fight!"
  puts "Please select pokemon to fight with!"
  showpokemons()
  puts "write the number of the pokemon or name. example: '1' or 'bulbasaur'"
  choosePokemon()
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

def choosePokemon()
  pokemonOfChoice = gets.chomp
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
end

startFight("Pikachu")