# Decorator Pattern
# Date: 21-Apr-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: coffee_test.rb

# Component class
# Represents a condiment thats added to the beverage, modifies its description and cost
class CondimentDecorator
    # Receives a beverage
    def initialize(beverage)
        @description = beverage.description
        @cost = beverage.cost
    end

    # Returns a new description
    def description
        @description
    end

    # Returns a new cost
    def cost
        @cost
    end
end

# Represents a Dark Roast Coffee
class DarkRoast
    # Sets description to 'Dark Roast Coffee' and cost to $0.99
    def initialize
        @description = "Dark Roast Coffee"
        @cost = 0.99
    end

    # Description reaader
    def description
         @description
    end

    # Cost reader
    def cost
        @cost
    end
end

# Represents an Espresso
class Espresso
     # Sets description to 'Espresso' and cost to $1.99
    def initialize
        @description = "Espresso"
        @cost = 1.99
    end

    # Description reader
    def description
        @description
    end

    # Cost reader
    def cost
        @cost
    end

end

# Represents a House Blend Coffee
class HouseBlend
     # Sets description to 'House Blend Coffee' and cost to $0.89
    def initialize
        @description = "House Blend Coffee"
        @cost = 0.89
    end

    # Description reader
    def description
         @description
    end

    # Cost Reader
    def cost
        @cost
    end
end

# Represents a Mocha condiment that inherits from CondimentDecorator
class Mocha < CondimentDecorator
    # Superclass initialize
    def initialize(beverage)
        super(beverage)
    end

    # Adds <em> Mocha </em> condiment to the beverage's description
    def description
        @description + ", Mocha"
    end

    # Adds an extra cost to the beverage's total cost
    def cost
        @cost + 0.20
    end
end

# Represents a Whip condiment that inherits from CondimentDecorator
class Whip < CondimentDecorator
    # Superclass initialize
    def initialize(beverage)
        super(beverage)
    end

    # Adds <em> Whip </em> condiment to the beverage's description
    def description
        @description + ", Whip"
    end

    # Adds an extra cost to the beverage's total cost
    def cost
        @cost + 0.10
    end
end

# Represents a Soy condiment that inherits from CondimentDecorator
class Soy < CondimentDecorator
    # Superclass initialize
    def initialize(beverage)
        super(beverage)
    end

    # Adds <em> Soy </em> condiment to the beverage's description
    def description
        @description + ", Soy"
    end

    # Adds an extra cost to the beverage's total cost
    def cost
        @cost + 0.15
    end
end

# Represents a Milk condiment that inherits from CondimentDecorator
class Milk < CondimentDecorator
    # Superclass initialize
    def initialize(beverage)
        super(beverage)
    end

    # Adds <em> Milk </em> condiment to the beverage's description
    def description
        @description + ", Milk"
    end

    # Adds an extra cost to the beverage's total cost
    def cost
        @cost + 0.10
    end
end
