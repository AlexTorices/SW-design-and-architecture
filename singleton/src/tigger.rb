# The source code contained in this file demonstrates how to
# implement the <em>single pattern</em>.

require 'singleton'

# A class that models the famous \Tigger character
# from A. A. Milne's “Winnie The Pooh” books.
class Tigger

  include Singleton

  # Returns the string representation of this tigger
  # instance.
  def to_s
    return "I'm the only one!"
  end

  # Returns a string with a tigger roar.
  def roar
    'Grrr!'
  end

end