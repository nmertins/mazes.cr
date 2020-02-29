require "../mazes/grid"

module Utils
  class UnicodeBuilder
    def self.to_unicode(grid : Mazes::Grid)
      String.build do |io|
        io << build_top_row(grid)
      end
    end

    private def self.build_top_row(grid : Mazes::Grid)
      ret = "\u250c"
      (0...grid.columns-1).each do |x|
        cell = grid[0, x].as(Mazes::Cell)
        top_right_corner = cell.linked?(cell.east) ? "\u2500" : "\u252c"
        ret += "\u{2500 2500 2500}" + top_right_corner
      end
      ret += "\u{2500 2500 2500 2510}\n"

      ret
    end
  end
end
