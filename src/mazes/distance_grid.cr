require "grid"
require "distances"

module Mazes
  class DistanceGrid < Grid
    property distances : Distances?

    def contents_of(cell)
      if @distances && @distances[cell]?
        @distances[cell].to_s(36)
      else
        super
      end
    end
  end
end
