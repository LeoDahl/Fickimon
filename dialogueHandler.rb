#dialogue file should match the part of the game you're in

#require_relative "dialogue/dialogueTest.rb"

def intro(dialoguePart)
    text = File.read(dialoguePart)


    choiceEndOrStart = 0

    choiceArr = []

    numberOfChoices = 0

    for i in 0..text.length

        if text[i] == "|"
            choiceEndOrStart += 1
        end

        if choiceEndOrStart == 1
            numberOfChoices += 1
            if text[i] != "|"
                choiceArr.push(text[i])
            end
        elsif choiceEndOrStart == 2
            input = gets.chomp
            if input != choiceArr.join

            if choiceArr.join() == "input"
            elsif choiceArr.join() == "yes/no"
            else

            end
            choiceEndOrStart = 0
            choiceArr = []
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

