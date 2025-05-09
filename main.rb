

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



def game_start()
  enemies = ["squirtle", "pikachu", "bulbasaur"]
  main = true
  while main
    diaNum = 0

    ## Open necessary files
    options = File.open("options.txt")

    #Get rows
    optionRows = options.readlines()

    puts "Type Start to begin!"
    notValid = true

    input = gets.chomp
    validInputs = ["Start", "start"]
    i = 0 
    while notValid
      notValid = true
      while i < validInputs.length
        if input == validInputs[i]
          notValid = false
        end
        i += 1
      end
    end
    if notValid
      puts "Invalid input, please try again"
      puts "Type Start to begin!"
      input = gets.chomp
    end
    # puts get_Dialogue(input.to_i) <---- Fungerar inte

    puts "Welcome to the world of Pokemon!"
    enemyIndex = rand(0..enemies.length-1)
    initFight(enemies[enemyIndex])
  end
end

game_start()