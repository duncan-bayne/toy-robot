require_relative 'table'
require_relative 'robot'

class Simulator

  def initialize
    @table = Table.new
    @robot = Robot.new
  end

  def execute(commands)
    commands.each { |command| execute_command(command) }
  end

  private

  def execute_command(command)
    tokens = command.split(/\s+/)
    operator = tokens.first
    arguments = tokens.last

    case operator
    when 'PLACE'
        place(arguments)
    end
  end

  def place(position)
    tokens = position.split(/,/)
    x = tokens[0].to_i
    y = tokens[1].to_i
    orientation = tokens[2].downcase.to_sym

    @table.place(x, y)
    @robot.orient(orientation)
  end

end
