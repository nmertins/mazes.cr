require "./distances"
require "json"

module Mazes
  class Cell
    property row
    property column
    property north : Cell?
    property south : Cell?
    property east : Cell?
    property west : Cell?
    @links : Hash(Cell, Bool)

    def initialize(row : Int32, column : Int32)
      @row = row
      @column = column
      @links = Hash(Cell, Bool).new
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

    def to_json
      String.build do |str|
        to_json(str)
      end
    end

    def to_json(io : IO)
      JSON.build(io) do |json|
        json.object do                  # build Cell object
          json.field "row", @row
          json.field "column", @column
        end
      end
    end
  end
end
