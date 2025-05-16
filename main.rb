

require_relative "fightHandler.rb"
require_relative "dialogueHandler.rb"
require_relative "pokemons.rb"
# def get_Dialogue(num)
#   dialoguesArrays = []
#   dialogue = File.open("dialouge.txt")
#   dialogueRows = dialogue.readlines()
#   x = 0
#   while x != dialogueRows.length do 
#     if dialogueRows[x][0] == "'"
#       dialoguesArrays << dialogueRows[x]
#     end
#     x = x + 1
#   end
#   return dialoguesArrays[num]
# end



def game_start() # LUCAS
  enemies = ["squirtle", "charmander", "bulbasaur"]
  main = true
  while main
    diaNum = 0

    ## Open necessary files
    options = File.open("options.txt")

    #Get rows
    optionRows = options.readlines()
    notValid = true

    validInputs = ["Start", "start"] 
    while notValid
      puts "Type Start to begin!"
      input = gets.chomp
      notValid = true
      i = 0
      while i < validInputs.length
        if input == validInputs[i]
          notValid = false
        end
        i += 1
      end
    end

    # puts get_Dialogue(input.to_i) <---- Fungerar inte
        #Här startar spelet
    puts "Welcome to the world of Pokemon!"

    if pathHandler("intro.txt", "exitHouse.txt", "stayHouse.txt") == "exitHouse.txt"
      #här bestäms paths
      if pathHandler("exitHouse.txt", "fight.txt", "notFight.txt") == "fight.txt"
        #slåss
      end
    elsif pathHandler("intro.txt", "exitHouse.txt", "stayHouse.txt") == "stayHouse.txt"
    end
    enemyIndex = rand(0..enemies.length-1)
    initFight(enemies[enemyIndex])
    # Efter fighthandler
  end
end

game_start()