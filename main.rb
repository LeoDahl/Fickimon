
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
  loop do
    input = gets
    while 
    puts input
    puts get_Dialogue(input.to_i)
  end
end

puts game_start()