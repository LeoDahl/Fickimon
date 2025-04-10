#dialogue file should match the part of the game you're in

require_relative "dialogue/dialogueTest.rb"

whatFood()

if whatFood() == "pancakes"
    pancake()
else
    puts "ew"
end
