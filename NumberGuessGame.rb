#---------
# name: NumberGuess.rb
#
#----------------
 
class Screen
 
 def cls
   puts ("\n" * 30)
   puts "\a"
 end
 
 def pause
    STDIN.gets
 end
 
end
 
class Game
    def display_greeting
        Console_Screen.cls
        print "\t\t Welcome to the Ruby Number Guessing Game!" +
        "\n\n\n\n\n\n\n\n\n\n\n\n\ Press Enter to " + 
        "continue."
 
        Console_Screen.pause
    end
 
    def display_instruction
        Console_Screen.cls
        puts "Instruction:\n\n"
 
        puts "This game randomly generates a number from 1 to 100 and "
        puts "challaenges you to identify it in as few guesses and possible "
    end
 
    def generate_number
        return randomNo = 1 + rand(1000)
    end
 
    def play_game
        number = generate_number
        loop do
            Console_Screen.cls
            print "\nEnter your guess and press the enter key: "
 
            reply = STDIN.gets
            reply.chop!
            # checking for invalid input
            hasCharacter = (reply =~ /^\d+$/) == nil
 
            # Game cheat!
            if (reply == "it is a good day to die") then
                Console_Screen.cls
                print "Game Number : #{number}. Press Enter to continue."
                Console_Screen.pause
                redo
            end
 
            reply = reply.to_i
 
            # Show error message for invalid input
            if reply < 1 or reply > 1000 or hasCharacter then
                Console_Screen.cls
                print "Invalid input! Input number only. Press Enter to continue." if hasCharacter
                print "Invalid input! Guessing out of range. Press Enter to continue." unless hasCharacter
                Console_Screen.pause
                redo # redo the ciurrent iteration of the loop
            end
 
            $guessCount[$gameCount] += 1
 
            if reply == number then
                Console_Screen.cls
                print "You have guessed the number! Press Enter to continue."
                Console_Screen.pause
                break
            elsif reply < number then
                Console_Screen.cls
                print "Your guess is too low! Press enter to continue."
                Console_Screen.pause
            elsif reply > number then
                Console_Screen.cls
                print "Your guess is too high! Press enter to continue."
                Console_Screen.pause
            end
            
            if ($guessCount[$gameCount] == 10) then
                Console_Screen.cls
                print "You lost! The number is #{number}. Press Enter to continue."
                Console_Screen.pause
                break
            end
            
        end
             
    end
 
    def display_credits
        Console_Screen.cls
        puts "\t\t\Thanks you for playing the number game!!"
    end
 
    $gameCount = 0 # Number of game played
    $guessCount = []
    $noRight = 0
 
    Console_Screen = Screen.new
 
    SQ = Game.new
 
    SQ.display_greeting
 
    answer = ""
 
    loop do
        Console_Screen.cls
 
        print "Are you ready to play the Ruby Number Guessing Game? (y/n): "
 
        answer = STDIN.gets
 
        answer.chop!
 
        break if answer == "y" || answer == "n"
    end
 
    if answer == "n"
 
        Console_Screen.cls
 
        puts "Perhaps anoher time.\n\n"
 
    else
        SQ.display_instruction
        
        loop do
            
            # Initialize guess count for new game
            $guessCount[$gameCount] = 0;
            
            SQ.play_game
            
            # increase game played by 1
            $gameCount += 1
            
            Console_Screen.cls
            
            averageGuess = ($guessCount.inject(0) { |sum, n| sum + n }) / $gameCount
            print "Game played : #{$gameCount}\t\tAverage Guess Made : #{averageGuess} \n"
            print "Would you like to play again? (y/n): "
 
            playAgain = STDIN.gets
            playAgain.chop!
 
            break if playAgain == "n"
        end
 
        SQ.display_credits
 
    end
 
end