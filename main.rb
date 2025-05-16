require_relative "fightHandler.rb"
require_relative "dialogueHandler.rb"
require_relative "pokemons.rb"
require_relative "pathHandler.rb"

File.open("Inventory_pokemon.txt", "w") do |file|
  file.print "CHARMANDER,1,1,1,100,100,FIRE,\n"
end

def game_start()
  enemies = ["squirtle", "charmander", "bulbasaur"]
  main = true
  while main
    diaNum = 0

    ## Open necessary files
    options = File.open("options.txt")

    #Get rows
    optionRows = options.readlines()
    notValid = true

    validInputs = "START" 
    while notValid
      puts "Type Start to begin!"
      input = gets.chomp.upcase
      notValid = true
      i = 0
      if input == validInputs
        notValid = false
      end
    end

    x = pathHandler("dialogue/intro.txt", "dialogue/exitHouse.txt", "dialogue/stayHouse.txt")
    if x == "dialogue/exitHouse.txt"
      dialogueHandler("dialogue/exitHouse.txt")
      puts "----------------------------------"
      puts "press ENTER to continue"
      gets.chomp
      enemyIndex = rand(0..enemies.length-1)
      initFight(enemies[enemyIndex])
    elsif x == "dialogue/stayHouse.txt"
      dialogueHandler("dialogue/stayHouse.txt")
      break
    end
  end
  while true
    puts "--------------------------------------"
    puts "press ENTER to to start a new fight"
    gets
    enemyIndex = rand(0..enemies.length-1)
    initFight(enemies[enemyIndex])
  end
end

game_start()