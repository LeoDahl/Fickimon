require_relative "dialogueHandler.rb"

#when yes or no question yes is ALWAYS first

def pathHandler(currentPath, path1, path2) 

    lastChoice, choices = dialogueHandler(currentPath)

    if lastChoice == choices[0]
        return path1
    elsif lastChoice == choices[1]
        return path2
    end
end


