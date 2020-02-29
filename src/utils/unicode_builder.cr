require "../mazes/grid"

module Utils
  class UnicodeBuilder
    def self.to_unicode(grid : Mazes::Grid)
      String.build do |io|
        io << build_top_row(grid)
        (0...grid.rows).each do |y|
          io << build_vertical_walls(y, grid)
        end
      end
    end

    private def self.build_top_row(grid : Mazes::Grid)
      ret = "\u250c"
      (0...grid.columns-1).each do |x|
        cell = grid[x, 0].as(Mazes::Cell)
        top_right_corner = cell.linked?(cell.east) ? "\u2500" : "\u252c"
        ret += "\u{2500 2500 2500}" + top_right_corner
      end
      ret += "\u{2500 2500 2500 2510}\n"

      ret
    end

    private def self.build_vertical_walls(row : Int32, grid : Mazes::Grid)
      ret = "\u2502"
      (0...grid.columns).each do |x|
        cell = grid[x, row].as(Mazes::Cell)
        right_border = cell.linked?(cell.east) ? " " : "\u2502"
        ret += "   " + right_border
      end
      ret += "\n"

      ret
    end

    private def self.build_horizontal_walls(top_row : Int32, bottom_row : Int32, grid : Mazes::Grid)
      (0...grid.columns).each do |x|
      end
    end
  end
end
