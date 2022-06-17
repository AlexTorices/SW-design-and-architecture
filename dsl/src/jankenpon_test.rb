# Domain-Specific Language Pattern
# Date: 28-Apr-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: jankenpon_test.rb

require 'minitest/autorun'
require 'stringio'
require 'jankenpon'

# Test class for Jankenpon game
class JakenponTest < Minitest::Test

    # Sets up the test environment.
  def setup
    @old_stdout = $stdout
    @out = $stdout = StringIO.new
  end

    # Runs after every test, rebuilds stdout.
  def teardown
    $stdout = @old_stdout
  end

    # Tests the result of the plus interaction
  def test_simple_cases_plus
    assert_equal Scissors, (Scissors + Paper)
    assert_equal Scissors, (Paper + Scissors)
    assert_equal Paper,    (Paper + Rock)
    assert_equal Paper,    (Rock + Paper)
    assert_equal Rock,     (Rock + Lizard)
    assert_equal Rock,     (Lizard + Rock)
    assert_equal Lizard,   (Lizard + Spock)
    assert_equal Lizard,   (Spock + Lizard)
    assert_equal Spock,    (Spock + Scissors)
    assert_equal Spock,    (Scissors + Spock)
    assert_equal Scissors, (Scissors + Lizard)
    assert_equal Scissors, (Lizard + Scissors)
    assert_equal Lizard,   (Lizard + Paper)
    assert_equal Lizard,   (Paper + Lizard)
    assert_equal Paper,    (Paper + Spock)
    assert_equal Paper,    (Spock + Paper)
    assert_equal Spock,    (Spock + Rock)
    assert_equal Spock,    (Rock + Spock)
    assert_equal Rock,     (Rock + Scissors)
    assert_equal Rock,     (Scissors + Rock)
    assert_equal Scissors, (Scissors + Scissors)
    assert_equal Paper,    (Paper + Paper)
    assert_equal Rock,     (Rock + Rock)
    assert_equal Lizard,   (Lizard + Lizard)
    assert_equal Spock,    (Spock + Spock)
  end

    # Tests the result of the minus interaction
  def test_simple_cases_minus
    assert_equal Paper,    (Scissors - Paper)
    assert_equal Paper,    (Paper - Scissors)
    assert_equal Rock,     (Paper - Rock)
    assert_equal Rock,     (Rock - Paper)
    assert_equal Lizard,   (Rock - Lizard)
    assert_equal Lizard,   (Lizard - Rock)
    assert_equal Spock,    (Lizard - Spock)
    assert_equal Spock,    (Spock - Lizard)
    assert_equal Scissors, (Spock - Scissors)
    assert_equal Scissors, (Scissors - Spock)
    assert_equal Lizard,   (Scissors - Lizard)
    assert_equal Lizard,   (Lizard - Scissors)
    assert_equal Paper,    (Lizard - Paper)
    assert_equal Paper,    (Paper - Lizard)
    assert_equal Spock,    (Paper - Spock)
    assert_equal Spock,    (Spock - Paper)
    assert_equal Rock,     (Spock - Rock)
    assert_equal Rock,     (Rock - Spock)
    assert_equal Scissors, (Rock - Scissors)
    assert_equal Scissors, (Scissors - Rock)
    assert_equal Scissors, (Scissors - Scissors)
    assert_equal Paper,    (Paper - Paper)
    assert_equal Rock,     (Rock - Rock)
    assert_equal Lizard,   (Lizard - Lizard)
    assert_equal Spock,    (Spock - Spock)
  end

    # Single show test
  def test_dsl_1
    #---------
    show Spock
    #---------
    assert_equal \
      "Result = Spock\n", @out.string
  end

    # Tests single plus interaction
  def test_dsl_2
    #------------------
    show Spock + Lizard
    #------------------
    assert_equal \
      "Lizard poisons Spock (winner Lizard)\n" \
      "Result = Lizard\n", \
      @out.string
  end

    # Tests single minus interaction
  def test_dsl_3
    #------------------
    show Spock - Lizard
    #------------------
    assert_equal \
      "Lizard poisons Spock (loser Spock)\n" \
      "Result = Spock\n", \
      @out.string
  end

    # Tests a bigger plus interaction
  def test_dsl_4
    #-------------------------
    show Spock + Lizard + Rock
    #-------------------------
    assert_equal \
      "Lizard poisons Spock (winner Lizard)\n" \
      "Rock crushes Lizard (winner Rock)\n" \
      "Result = Rock\n", \
      @out.string
  end

    # Tests a bigger plus interaction with parenthesis
  def test_dsl_5
    #---------------------------
    show Spock + (Lizard + Rock)
    #---------------------------
    assert_equal \
      "Rock crushes Lizard (winner Rock)\n" \
      "Spock vaporizes Rock (winner Spock)\n" \
      "Result = Spock\n", \
      @out.string
  end

    # Tests an even bigger plus interaction
  def test_dsl_6
    #--------------------------------------------
    show Rock + Paper + Scissors + Lizard + Spock
    #--------------------------------------------
    assert_equal \
      "Paper covers Rock (winner Paper)\n" \
      "Scissors cut Paper (winner Scissors)\n" \
      "Scissors decapitate Lizard (winner Scissors)\n" \
      "Spock smashes Scissors (winner Spock)\n" \
      "Result = Spock\n", \
      @out.string
  end

    # Tests a big minus interaction
  def test_dsl_7
    #--------------------------------------------
    show Rock - Paper - Scissors - Lizard - Spock
    #--------------------------------------------
    assert_equal \
      "Paper covers Rock (loser Rock)\n" \
      "Rock crushes Scissors (loser Scissors)\n" \
      "Scissors decapitate Lizard (loser Lizard)\n" \
      "Lizard poisons Spock (loser Spock)\n" \
      "Result = Spock\n", \
      @out.string
  end

    # Tests a combination of minus and plus interactions with parenthesis
  def test_dsl_8
    #-------------------------------------------------
    show((Rock + Paper) - (Scissors + Lizard) + Spock)
    #-------------------------------------------------
    assert_equal \
      "Paper covers Rock (winner Paper)\n" \
      "Scissors decapitate Lizard (winner Scissors)\n" \
      "Scissors cut Paper (loser Paper)\n" \
      "Paper disproves Spock (winner Paper)\n" \
      "Result = Paper\n", \
      @out.string
  end

    # Another complex tests, with parenthesis inside parenthesis
  def test_dsl_9
    #---------------------------------------------
    show Paper + ((Spock + Paper) - Lizard + Rock)
    #---------------------------------------------
    assert_equal \
      "Paper disproves Spock (winner Paper)\n" \
      "Lizard eats Paper (loser Paper)\n" \
      "Paper covers Rock (winner Paper)\n" \
      "Paper tie (winner Paper)\n" \
      "Result = Paper\n", \
      @out.string
  end

end