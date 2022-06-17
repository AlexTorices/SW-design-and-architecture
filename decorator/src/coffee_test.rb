# Decorator Pattern
# Date: 21-Apr-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: coffee_test.rb

require 'minitest/autorun'
require 'coffee'

# Test class for beverages
class CoffeeTest < Minitest::Test

    # Espresso test
    # Checks that a beverage without condiments works fine
  def test_espresso
    beverage = Espresso.new
    assert_equal("Espresso", beverage.description)
    assert_equal(1.99, beverage.cost)
  end

    # Dark Roast Coffee Test
    # Base beverage with Milk, double Mocha and Whip
  def test_dark_roast
    beverage = DarkRoast.new
    beverage = Milk.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("Dark Roast Coffee, Milk, Mocha, Mocha, Whip",
                 beverage.description)
    assert_equal(1.59, beverage.cost)
  end

    # House Blend Coffee Test
    # Last base beverage with Soy, Mocha and Whip
  def test_house_blend
    beverage = HouseBlend.new
    beverage = Soy.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("House Blend Coffee, Soy, Mocha, Whip",
                 beverage.description)
    assert_equal(1.34, beverage.cost)
  end

end