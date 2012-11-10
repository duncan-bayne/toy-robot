class Table

  attr_accessor :position

  def place(x, y)
    self.position = { x: x, y: y } if valid_coordinates?(x, y) 
  end

  private

  def valid_coordinates?(x, y)
    (x >= 0 && x <= 4 && y >= 0 && y <= 4)
  end
end
