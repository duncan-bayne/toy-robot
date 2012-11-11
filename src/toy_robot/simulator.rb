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
      @table.placed? ? report : "Ignoring REPORT until robot is PLACEd."
    when 'MOVE'
      @table.placed? ? move : "Ignoring MOVE until robot is PLACEd."
    when 'LEFT'
      @table.placed? ? left : "Ignoring LEFT until robot is PLACEd."
    when 'RIGHT'
      @table.placed? ? right : "Ignoring RIGHT until robot is PLACEd."
    else
      "Ignoring invalid command #{operator}."
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
    begin
      tokens = position.split(/,/)
      x = tokens[0].to_i
      y = tokens[1].to_i
      orientation = tokens[2].downcase.to_sym

      @table.place(x, y) if @robot.orient(orientation)
      nil
    rescue
      "Ignoring PLACE with invalid arguments."
    end
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
