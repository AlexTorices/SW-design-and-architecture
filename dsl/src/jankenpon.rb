# Domain-Specific Language Pattern
# Date: 28-Apr-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: jankenpon.rb

# Represents an option of jankenpon
class Option
    RULES = {}
    VAL = :Option

    # Method for the plus interaction
    def self.+(option)
        temp = vs(self, option, "winner")
        if temp
            return temp
        end
        vs(option, self, "winner")
    end

    # Method for the less interaction
    def self.-(option)
        temp = vs(option, self, "loser")
        if temp
            return temp
        end
        vs(self, option, "loser")
    end

end

# Defines a Scissors option
class Scissors < Option
    # Beats Paper and Lizard
    RULES = {Paper: "cut", Lizard: "decapitate"}
    VAL = :Scissors

end

# Defines a Paper Option
class Paper < Option
    # Beats Rock and Spock
    RULES = {Rock: "covers", Spock: "disproves"}
    VAL = :Paper

end

# Defines a Spock option
class Spock < Option
    # Beats Scissors and Rock
    RULES = {Scissors: "smashes", Rock: "vaporizes"}
    VAL = :Spock

end

# Defines a Rock option
class Rock < Option
    # Beats Lizard and Scissors
    RULES = {Lizard: "crushes", Scissors: "crushes"}
    VAL = :Rock

end

# Defines a Lizard Option
class Lizard < Option
    # Beats Spock and Paper
    RULES = {Spock: "poisons", Paper: "eats"}
    VAL = :Lizard

end

# Show method used to print the result of the game
def show(result)
    puts "Result = #{result}"

end

# vs method used to decide who wins or loses and prints the outcome
def vs(option1, option2, action)
    if option1::VAL == option2::VAL
        puts "#{option1} tie (#{action} #{option1})"
        return option1
    end

    if !option1::RULES.has_key?(option2::VAL)
        return false
    end

    puts "#{option1} #{option1::RULES.fetch(option2::VAL)} #{option2}" + " (#{action} #{action == 'winner' ? option1 : option2 })"
    if action == "winner"
        option1
    else
        option2
    end


end

