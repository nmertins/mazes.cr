module Mazes
  class Cell
    property row
    property column
    property north
    property south
    property east
    property west

    def initialize(row : Int32, column : Int32)
      @row = row
      @column = column
      @links = {} of Cell => Bool
    end

    def link(cell, bidirectional = true)
      @links[cell] = true
      cell.link(self, false) if bidirectional
      self
    end

    def unlink(cell, bidirectional = true)
      @links.delete(cell)
      cell.unlink(self, false) if bidirectional
      self
    end

    def links
      @links.keys
    end

    def linked?(cell)
      @links.has_key?(cell)
    end
  end
end