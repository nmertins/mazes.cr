module Mazes
  class Distances
    def initialize(@root : Cell)
      @cells = {} of Cell => Int32
      @cells[@root] = 0
    end

    def [](cell)
      @cells[cell]
    end

    def []?(cell)
      @cells[cell]?
    end

    def []=(cell, distance)
      @cells[cell] = distance
    end

    def cells
      @cells.keys
    end
  end
end
