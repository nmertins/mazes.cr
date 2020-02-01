module Mazes
  class Cell
    property row
    property column
    
    def initialize(row : Int32, column : Int32)
      @row = row
      @column = column
    end
  end
end