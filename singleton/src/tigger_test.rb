# Source code with the unit tests that check the 
# correct implementation for the <em>singleton 
# pattern</em>.

require 'minitest/autorun'
require 'tigger'

# Unit tests for the Tigger class.
class TiggerTest < Minitest::Test
    
  # Verifies that the class has a unique instance every time
  # the +instance+ method gets called.
  def test_instance
    t = Tigger.instance
    assert_same(t, Tigger.instance)
  end
  
  # Makes sure you cannot call the +new+ method because
  # it should be private.
  def test_new
    assert_raises(NoMethodError) do
      Tigger.new
    end
  end

  # Checks that the +to_s+ method works as expected.
  def test_to_s
    t = Tigger.instance
    assert_equal("I'm the only one!", t.to_s)
  end
    
  # Checks that the +roar+ method works as expected.
  def test_roar
    t = Tigger.instance
    assert_equal('Grrr!', t.roar)
  end

end