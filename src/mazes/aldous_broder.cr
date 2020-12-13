module Mazes
  class AldousBroder
    def solf.on(grid : Mazes::Grid)
      cell = grid.random_cell
      unvisited = grid.size - 1

      while unvisited > 0
        neighbor = cell.neighbors.sample

        if neighbor.links.empty?
          cell.link(neighbor)
          unvisited = unvisited - 1
        end

        cell = neighbor
      end
    end
  end
end