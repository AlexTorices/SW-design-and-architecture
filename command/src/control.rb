# Observer Pattern
# Date: 24-Mar-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: control.rb

# Represents a remote control with different buttons bound to specific devices.
# The control has a button to undo the last action.
class RemoteControlWithUndo

  # Initializes the remote control, creates an array with the buttons.
  # Bounds the NoCommand to each button.
  def initialize
    @on_commands = []
    @off_commands = []
    no_command = NoCommand.new
    7.times do
      @on_commands << no_command
      @off_commands << no_command
    end
    @undo_command = no_command
  end

  # Bounds a command action to a button slot.
  def set_command(slot, on_command, off_command)
    @on_commands[slot] = on_command
    @off_commands[slot] = off_command
  end

  # Executes the on method of a especific command.
  # Assigns the last executed command to the undo_command variable.
  def on_button_was_pushed(slot)
    @on_commands[slot].execute
    @undo_command = @on_commands[slot]
  end

  # Executes the off method of a especific command.
  # Assigns the last executed command to the undo_command variable.
  def off_button_was_pushed(slot)
    @off_commands[slot].execute
    @undo_command = @off_commands[slot]
  end

  # Unexecutes the last executed command.
  def undo_button_was_pushed()
    @undo_command.undo
  end

  # Returns a description of the remote control.
  # Shows the links bettwen commands and buttons.
  def inspect
    string_buff = ["\n------ Remote Control -------\n"]
    @on_commands.zip(@off_commands) \
        .each_with_index do |commands, i|
      on_command, off_command = commands
      string_buff << \
      "[slot #{i}] #{on_command.class}  " \
        "#{off_command.class}\n"
    end
    string_buff << "[undo] #{@undo_command.class}\n"
    string_buff.join
  end

end

# Base command, does nothing.
class NoCommand

  # No execution.
  def execute
  end

  # Undoes nothing.
  def undo
  end

end

# Represents a light switch, bound to the remote control.
class Light

  attr_reader :level

  # Initializes the fan, with a location in the house.
  # The base level is 0
  def initialize(location)
    @location = location
    @level = 0
  end

  # Switch on the light.
  def on
    @level = 100
    puts "Light is on"
  end

  # Switch off the light.
  def off
    @level = 0
    puts "Light is off"
  end

  # Dims the light to a certain level.
  # Prints the level or switchs off the light if 0
  def dim(level)
    @level = level
    if level == 0
      off
    else
      puts "Light is dimmed to #{@level}%"
    end
  end
end

# Represents a ceiling fan switch, bound to the remote control.
class CeilingFan

  # Access these constants from outside this class as
  # CeilingFan::HIGH, CeilingFan::MEDIUM, and so on.
  HIGH   = 3
  MEDIUM = 2
  LOW    = 1
  OFF    = 0

  attr_reader :speed

  # Initializes the fan, in an off state and in certain location.
  def initialize(location)
    @location = location
    @speed = OFF
  end

  # Sets the fan speed to high and prints a message
  def high
    @speed = HIGH
    puts "#{@location} ceiling fan is on high"
  end

  # Sets the fan speed to medium and prints a message
  def medium
    @speed = MEDIUM
    puts "#{@location} ceiling fan is on medium"
  end

  # Sets the fan speed to low and prints a message
  def low
    @speed = LOW
    puts "#{@location} ceiling fan is on low"
  end

  # Sets the fan speed to off and prints a message
  def off
    @speed = OFF
    puts "#{@location} ceiling fan is off"
  end

end

# Represents the switch on action of the light switch.
class LightOnCommand

  # Receives a certain light switch.
  # Remembers the current level
  def initialize(light)
    @light = light
    @level = @light.level
  end

  # Switchs on the light and remembers the previous level
  def execute
    @level = @light.level
    @light.on
  end

  # Returns the light to the level it had previously.
  def undo
    if(@level==100)
      @light.on
    else
      @light.dim(@level)
    end
  end

end

# Represents the switch off action of the light switch.
class LightOffCommand

  # Receives a certain light switch.
  # Remembers the current level
  def initialize(light)
    @light = light
    @level = @light.level
  end

  # Switchs off the light and remembers the previous level
  def execute
    @level = @light.level
    @light.off
  end

  # Returns the light to the level it had previously.
  def undo
    if(@level==100)
      @light.on
    else
      @light.dim(@level)
    end
  end

end

# Represents the set high speed action of the ceiling fan.
class CeilingFanHighCommand

  # Receives a certain ceiling fan
  # Remembers the current speed
  def initialize(fan)
    @fan = fan
    @speed = @fan.speed
  end

  # Sets fan speed to high and remembers the previous speed.
  def execute
    @speed = @fan.speed
    @fan.high
  end

  # Returns the ceiling fan to the speed it had previously.
  def undo
    if (@speed == CeilingFan::OFF)
      @fan.off
    elsif (@speed == CeilingFan::LOW)
      @fan.low
    elsif (@speed == CeilingFan::MEDIUM)
      @fan.medium
    else
      @fan.high
    end
  end

end

# Represents the set medium speed action of the ceiling fan.
class CeilingFanMediumCommand

  # Receives a certain ceiling fan
  # Remembers the current speed
  def initialize(fan)
    @fan = fan
    @speed = @fan.speed
  end

  # Sets fan speed to medium and remembers the previous speed.
  def execute
    @speed = @fan.speed
    @fan.medium
  end

  # Returns the ceiling fan to the speed it had previously.
  def undo
    if (@speed == CeilingFan::OFF)
      @fan.off
    elsif (@speed == CeilingFan::LOW)
      @fan.low
    elsif (@speed == CeilingFan::MEDIUM)
      @fan.medium
    else
      @fan.high
    end
  end

end

# Represents the turn off action of the ceiling fan.
class CeilingFanOffCommand

  # Receives a <em>certain</em> ceiling fan
  # Remembers the current speed
  def initialize(fan)
    @fan = fan
    @speed = @fan.speed
  end

  # Sets turns off the fan and remembers the previous speed.
  def execute
    @speed = @fan.speed
    @fan.off
  end

  # Returns the ceiling fan to the speed it had previously.
  def undo
    if (@speed == CeilingFan::OFF)
      @fan.off
    elsif (@speed == CeilingFan::LOW)
      @fan.low
    elsif (@speed == CeilingFan::MEDIUM)
      @fan.medium
    else
      @fan.high
    end
  end

end
