require "./grid"
require "./distances"

module Mazes
  class DistanceGrid < Grid
    property distances : Distances?

    def contents_of(cell)
      unless @distances.nil?
        distances = @distances.as(Distances)
        if distances[cell]?
          return distances[cell].to_s(36)
        end
      end

      super
    end
  end
end
