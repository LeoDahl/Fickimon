require_relative "dialogueHandler.rb"

#when yes or no question yes is ALWAYS first

def pathHandler(currentPath, path1, path2) 
    #Dir.chdir("dialogue")

    lastChoice = dialogueHandler(currentPath)[0]
    choices = dialogueHandler(currentPath)[1] 

    if lastChoice == choices[0]
        return path1
    elsif lastChoice == choices[1]
        return path2
    end
end

    
if pathHandler("dialogue/intro.txt", "dialogue/exitHouse.txt", "dialogue/stayHouse.txt") == "dialogue/exitHouse.txt"

    if pathHandler("dialogue/exitHouse.txt", "dialogue/fight.txt", "dialogue/notFight.txt") == "dialogue/fight.txt"
        #slåss
    end
elsif pathHandler("dialogue/intro.txt", "dialogue/exitHouse.txt", "dialogue/stayHouse.txt") == "dialogue/stayHouse.txt"

end

