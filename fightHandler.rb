def startFight(pokemon)
  puts pokemon + " wishes to fight!"
  puts "Please select pokemon to fight with!"
  currentPokemon = selectPokemon()
end

def selectPokemon()
  pokemons = File.readlines("Inventory_pokemon.txt")
  i = 0
  while i < pokemons.length
    print "#{i+1}. "
    puts pokemons[i][0] # Skriver inte ut namnet på pokemon
    i += 1
  end
end

selectPokemon()