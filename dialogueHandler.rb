#dialogue file should match the part of the game you're in

#require_relative "dialogue/dialogueTest.rb"

def intro(dialoguePart)
    text = File.read(dialoguePart)

    dialogue = false

    for i in 0..text.length
        if dialogue == true
            print text[i]
        end


        if text[i] == "#"
            if dialogue == false
                dialogue = true
            else
                dialogue = false
            end
        end

        

    end

end

def checkForHash(bool, arr, index)
    if arr[index] == "#"
        if bool == false
            bool = true
        else
            bool = false
        end
    end
end

p intro("dialogue/intro.txt")

