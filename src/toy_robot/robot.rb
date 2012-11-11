class Robot

  attr_accessor :orientation

  def left
    self.orientation = { north: :west, west: :south, south: :east, east: :north }[self.orientation]
  end

  def orient(orientation)
    if [ :north, :south, :west, :east ].include?(orientation)
      self.orientation = orientation
    else
      nil
    end
  end

  def right
    self.orientation = { north: :east, west: :north, south: :west, east: :south }[self.orientation]
  end

  def vector
    case self.orientation
    when :north
      { x: 0, y: 1 }
    when :south
      { x: 0, y: -1 }
    when :west
      { x: -1, y: 0 }
    when :east
      { x: 1, y: 0 }
    end
  end
end
