#dialogue file should match the part of the game you're in

#last input of the file determines path(important choice)

def dialogueHandler(dialoguePart)
    text = File.read(dialoguePart)

    input = ""

    choiceEndOrStart = 0

    choice = []

    allChoices = []

    choiceError = false

    for i in 0..text.length

        if text[i] == "|"
            choiceEndOrStart += 1
        end

        if choiceEndOrStart == 1

            if text[i] != "|"
                allChoices.push(text[i])
            end
        elsif choiceEndOrStart == 2
            choiceEndOrStart = 0
        end
    end

    for i in 0..text.length

        if text[i] == "|"
            choiceEndOrStart += 1
        end

        if choiceEndOrStart == 1
            if text[i] != "|"
                choice.push(text[i])
            end
        elsif choiceEndOrStart == 2

            if choice.join() == "input"
                input = gets.chomp
                
            elsif choice.join() == "yes/no"

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

                if choice.join().include? input
                    print("your choice: #{input}")
                else
                    choiceError = true
                    while choiceError == true
                        print("Your choices are #{choice.join()}: ")
                        input = gets.chomp
                        if choice.join().include? input
                            print("your choice: #{input}")
                            choiceError = false
                        end
                    end
                end
            end

            if lastChoice(allChoices, choice) == false
                choiceArr = []
            end  
            choiceEndOrStart = 0     
        else
            print(text[i])
            #sleep(0.05)
        end
           
    end

    p [input, choiceArr, allChoices]
end

def lastChoice(allChoicesArr, choiceArr)
    matchCount = 0;

    for i in (allChoices.length-choiceArr.length)..allChoices.length #ändra om
        if choiceArr[i] == allChoices[i]
            matchCount += 1
        end
    end

    if matchCount == choiceArr.length #här också
        return true
    else
        return false
    end
end


dialogueHandler("dialogue/intro.txt")

