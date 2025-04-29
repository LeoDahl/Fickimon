

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


enemies = ["pikachu", "bulbasaur"]

def game_start()
  main = true
  while main
    
    diaNum = 0
    ## Open necessary files
    
    options = File.open("options.txt")
    #Get rows
    optionRows = options.readlines()

    puts "Type Start to begin!"
    notValid = true

    loop do
      input = gets.chomp
      validInputs = ["Start", "start"]
      i = 0 
      while notValid
        notValid = true
        while i < validInputs.length
          i += 1
          if i == validInputs
            notValid = false
            break
          end
        end
      end
      puts input
      puts get_Dialogue(input.to_i)
    end
    
    game_start()
    enemyIndex = rand(0..enemies.length-1)
    initFight(enemies[enemyIndex])
  end
end

game_start()