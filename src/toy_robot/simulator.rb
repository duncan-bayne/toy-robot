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
      nil
    when 'REPORT'
      report
    when 'MOVE'
      move
    when 'LEFT'
      left
    when 'RIGHT'
      right
    end
  end

  private 

  def left
    @robot.left
    nil
  end

  def move
    vector = @robot.vector
    position = @table.position
    @table.place(position[:x] + vector[:x], position[:y] + vector[:y])
    nil
  end

  def place(position)
    tokens = position.split(/,/)
    x = tokens[0].to_i
    y = tokens[1].to_i
    orientation = tokens[2].downcase.to_sym

    @table.place(x, y)
    @robot.orient(orientation)
    nil
  end

  def report
    position = @table.position
    orientation = @robot.orientation
    "#{position[:x]},#{position[:y]},#{orientation.to_s.upcase}"
  end

  def right
    @robot.right
    nil
  end
end
