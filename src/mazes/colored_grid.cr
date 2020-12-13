require "./distance_grid"
require "stumpy_png"

include StumpyPNG

module Mazes
  class ColoredGrid < DistanceGrid
    def initialize(rows : Int32, columns : Int32)
      @maximum = 0
      super
    end

    def distances=(distances)
      @distances = distances
      _, @maximum = distances.max
    end

    def background_color_for(cell)
      if @distances
        distance = @distances.as(Mazes::Distances)[cell]?
        if distance
          intensity = (@maximum - distance).to_f / @maximum
          dark = (255 * intensity).round
          bright = 128 + (127 * intensity).round
          return RGBA.from_rgb_n(dark, bright, dark, 8)
        end
      end

      super
    end
  end
end
