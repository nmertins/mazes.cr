require "./distances"

module Mazes
  class Cell
    property row
    property column
    property north : Cell?
    property south : Cell?
    property east : Cell?
    property west : Cell?

    def initialize(row : Int32, column : Int32)
      @row = row
      @column = column
      @links = {} of Cell => Bool
    end

    def link(cell : Cell, bidirectional = true)
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

    def neighbors
      neighbors = [] of Cell
      neighbors << north.as(Cell) if north
      neighbors << south.as(Cell) if south
      neighbors << east.as(Cell) if east
      neighbors << west.as(Cell) if west
      neighbors
    end

    def distances
      distances = Distances.new(self)
      frontier = [ self ]

      while frontier.any?
        new_frontier = [] of Cell

        frontier.each do |cell|
          cell.links.each do |linked|
            next if distances[linked]?
            distances[linked] = distances[cell] + 1
            new_frontier << linked
          end
        end

        frontier = new_frontier
      end

      distances
    end
  end
end
