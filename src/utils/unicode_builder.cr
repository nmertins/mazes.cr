require "../mazes/grid"

module Utils
  class UnicodeBuilder
    def self.to_unicode(grid : Mazes::Grid)
      String.build do |io|
        io << "\u250c" + "\u{2500 2500 2500 2500}" * (grid.columns - 1) + "\u{2500 2500 2500 2510}" + "\n"

        grid.each_row do |row|
          is_last_row = row[0].row == (grid.rows - 1)
          top = "\u2502"
          bottom = is_last_row ? "\u2514" : "\u2502"

          row.each do |cell|
            is_last_cell = cell.column == (grid.columns - 1)
            body = "   "
            east_boundary = (cell.linked?(cell.east) ? " " : "\u2502")
            top += body + east_boundary

            south_boundary = (cell.linked?(cell.south) ? "   " : "\u{2500 2500 2500}")

            unless is_last_row
              if is_last_cell
                corner =  "\u2502"
              else
                corner = "\u253c"
              end
            else
              if is_last_cell
                corner = "\u2518"
              else
                corner = "\u2500"
              end
            end

            bottom += south_boundary + corner
          end

          io << top + "\n"
          io << bottom + "\n"
        end
      end
    end
  end
end
