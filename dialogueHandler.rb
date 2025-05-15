#dialogue file should match the part of the game you're in

#last input of the file determines path(important choice)

input = ""

def dialogueHandler(dialoguePart)
    text = File.read(dialoguePart)

    input = ""

    choiceEndOrStart = 0

    choiceArr = []

    allChoices = []

    numberOfChoices = 0

    choiceError = false

    for i in 0..text.length

        if text[i] == "|"
            choiceEndOrStart += 1
        end

        if choiceEndOrStart == 1
            numberOfChoices += 1
            if text[i] != "|"
                choiceArr.push(text[i])
                allChoices.push(text[i])
            end
        elsif choiceEndOrStart == 2

            if choiceArr.join() == "input"
                input = gets.chomp
                
            elsif choiceArr.join() == "yes/no"

                print("type y for yes and n for no: ");
                input = gets.chomp

                if input != "y"|| input != "n" 

                    choiceError = true
                    while choiceError == true

                        print("ERROR, type y for yes and n for no: ");
                        input = gets.chomp

                        if input == "y"|| input == "n"
                            choiceError = false
                        end

                    end
                end

            else
                input = gets.chomp

                if choiceArr.join().include? input
                    print("your choice: #{input}")
                else
                    choiceError = true
                    while choiceError == true
                        print("Your choices are #{choiceArr.join()}: ")
                        input = gets.chomp
                        if choiceArr.join().include? input
                            print("your choice: #{input}")
                            choiceError = false
                        end
                    end
                end
            end

            if lastChoice(allChoices, choiceArr) == false
                choiceArr = []
            end

            choiceEndOrStart = 0
            
        else
            print(text[i])
            #sleep(0.05)
        end                   
    end
    p [input, choiceArr]
end

def lastChoice(allChoices, choiceArr)
    matchCount = 0;

    for i in (allChoices.length-choiceArr.length)..allChoices.length-1
        if allChoices[i] == choiceArr[i]
            matchCount += 1
        end
    end

    if matchCount == choiceArr.length-1
        return true
    else
        return false
    end
end


dialogueHandler("dialogue/intro.txt")

