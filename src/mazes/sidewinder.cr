module Mazes
  class Sidewinder
    def self.on(grid : Mazes::Grid)
      grid.each_row do |row|
        run = [] of Cell
        row.each do |cell|
          run << cell

          at_eastern_boundary = (cell.east == nil)
          at_northern_boundary = (cell.north == nil)

          should_close_out = at_eastern_boundary || (!at_northern_boundary && rand(2) == 0)

          if should_close_out
            member = run.sample
            member.link(member.north.as(Cell)) if member.north
            run.clear
          else
            cell.link(cell.east.as(Cell))
          end
        end
      end

      grid
    end
  end
end