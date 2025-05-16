#dialogue file should match the part of the game you're in

#last input of the file determines path(important choice)

#when yes or no question yes is ALWAYS first

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
                
            # elsif choice.join() == "yes/no"

            #     print("type yes or no: ");
            #     input = gets.chomp

            #     if input != "yes"|| input != "no" 

            #         choiceError = true
            #         while choiceError == true

            #             print("ERROR, type yes or no: ");
            #             input = gets.chomp

            #             if input == "yes"|| input == "no"
            #                 choiceError = false
            #             end

            #         end
            #     end

            else
                input = gets.chomp

                if choice.join().split(",").include? input
                    print("your choice: #{input}")
                else
                    choiceError = true
                    while choiceError == true
                        print("Your choices are #{choice.join()}: ")
                        input = gets.chomp
                        if choice.join().split(",").include? input
                            print("your choice: #{input}")
                            choiceError = false
                        end
                    end
                end
            end

            if lastChoice(allChoices, choice) == false
                choice = []
            end  
            choiceEndOrStart = 0     
        else
            print(text[i])
            sleep(0.05)
        end
           
    end

    return [input, choice.join().split(",")]
end

def lastChoice(allChoicesArr, choiceArr)
    matchCount = 0;
    startValue = (allChoicesArr.length-choiceArr.length)

    for i in (allChoicesArr.length-choiceArr.length)..allChoicesArr.length-1
        if choiceArr[i-startValue] == allChoicesArr[i]
            matchCount = matchCount + 1
        end
    end

    if matchCount == choiceArr.length
        return true
    else
        return false
    end
end

