
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
  diaNum = 0
  ## Open necessary files
  
  options = File.open("options.txt")
  #Get rows
  optionRows = options.readlines()

  puts "Type Start to begin!"
  while


  loop do
    input = gets.chomp
    validInputs = get_Valid_Inputs() ##<-- inte riktig funktion än
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
end

puts game_start()