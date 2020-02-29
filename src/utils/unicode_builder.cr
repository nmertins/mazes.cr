require "../mazes/grid"

module Utils
  class UnicodeBuilder
    def self.to_unicode(grid : Mazes::Grid)
      String.build do |io|
        io << build_top_row(grid)
        (0...grid.rows).each do |y|
          io << build_vertical_walls(y, grid)
          io << build_horizontal_walls(y, grid) unless y == grid.rows-1
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

    private def self.build_horizontal_walls(row : Int32, grid : Mazes::Grid)
      ret = ""

      first_cell = grid[0, row].as(Mazes::Cell)
      ret += first_cell.linked?(first_cell.south) ? "\u2502" : "\u251c"

      (0...grid.columns-1).each do |x|
        cell = grid[x, row].as(Mazes::Cell)
        horizontal_wall = cell.linked?(cell.south) ? "   " : "\u{2500 2500 2500}"
        diag_neighbor = grid[x+1, row+1].as(Mazes::Cell)
        north_wall_exists = !cell.linked?(cell.east)
        west_wall_exists = !cell.linked?(cell.south)
        east_wall_exists = !diag_neighbor.linked?(diag_neighbor.north)
        south_wall_exists = !diag_neighbor.linked?(diag_neighbor.west)
        cell_junction = get_cell_junction(north_wall_exists, south_wall_exists, east_wall_exists, west_wall_exists)
        ret += horizontal_wall + cell_junction
      end

      last_cell = grid[grid.columns-1, row].as(Mazes::Cell)
      ret += last_cell.linked?(last_cell.south) ? "   " + "\u2502\n" : "\u{2500 2500 2500 2524}\n"

      ret
    end

    private def self.get_cell_junction(north_wall_exists : Bool, south_wall_exists : Bool, east_wall_exists : Bool, west_wall_exists : Bool)
      case {north_wall_exists, south_wall_exists, east_wall_exists, west_wall_exists}
      when {true, true, true, true}
        return "\u253c"
      when {false, true, true, true}
        return "\u252c"
      when {true, false, true, true}
        return "\u2534"
      when {true, true, false, true}
        return "\u2524"
      when {true, true, true, false}
        return "\u251c"
      when {false, false, true, true}
        return "\u2500"
      when {false, true, false, true}
        return "\u2510"
      when {false, true, true, false}
        return "\u250c"
      else
        return " "
      end
    end
  end
end
