#open this file with function to start dialogue

def whatFood()


    puts "This is a test dialouge"
    puts "Down below is three options"
    puts "pancakes, ice cream or pizza"

    options = ["pancakes", "ice scream", "pizza"]

    chosenOption = gets.chomp

    count = 0
    for i in 0..options.length
        if chosenOption == options[i]
            count += 1
        end
    end

    if count == 0
        puts "your choice: #{chosenOption}"
        return chosenOption
    else
        return "invalid choice"
    end
end

def pancakes()

    puts "pancakes are so yummr"
    puts "eat the pancake?"

    options = ["eat pancake", "dont eat pancake"]

    chosenOption = gets.chomp

    count = 0
    for i in 0..options.length
        if chosenOption == options[i]
            count += 1
        end
    end

    if count != 0
        return "invalid option"
    else
        return chosenOption
    end
end