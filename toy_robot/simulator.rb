require_relative 'table'
require_relative 'robot'

class Simulator

  def initialize
    @table = Table.new
    @robot = Robot.new
  end

  def execute(command)
    tokens = command.split(/\s+/)
    operator = tokens.first
    arguments = tokens.last

    case operator
    when 'PLACE'
      place(arguments)
    when 'REPORT'
      report
    when 'MOVE'
      move
    when 'LEFT'
      left
    when 'RIGHT'
      right
    else
      "Ignoring invalid command #{operator}."
    end
  end

  private 

  def left
    return 'Ignoring LEFT until robot is PLACEd.' unless @table.placed?
    @robot.left
    nil
  end

  def move
    return 'Ignoring MOVE until robot is PLACEd.' unless @table.placed?
    vector = @robot.vector
    position = @table.position
    @table.place(position[:x] + vector[:x], position[:y] + vector[:y])
    nil
  end

  def place(position)
    message = nil

    begin
      tokens = position.split(/,/)
      x = tokens[0].to_i
      y = tokens[1].to_i
      orientation = tokens[2].downcase.to_sym

      unless @robot.orient(orientation) && @table.place(x, y)
        message = "Ignoring PLACE with invalid arguments."
      end
    rescue
      message = "Ignoring PLACE with invalid arguments."
    end

    message
  end

  def report
    return 'Ignoring REPORT until robot is PLACEd.' unless @table.placed?
    position = @table.position
    orientation = @robot.orientation
    "#{position[:x]},#{position[:y]},#{orientation.to_s.upcase}"
  end

  def right
    return 'Ignoring RIGHT until robot is PLACEd.' unless @table.placed?
    @robot.right
    nil
  end
end
