module Mazes
  class Wilsons
    def self.on(grid : Mazes::Grid)
      unvisited = [] of Mazes::Cell
      grid.each_cell do |cell|
        unvisited << cell
      end
      start_cell = unvisited.sample
      unvisited.delete(start_cell)
      
      until unvisited.size == 0
        path = [] of Mazes::Cell
        current = unvisited.sample
        path << current

        while unvisited.includes?(current)
          neighbor = current.neighbors.sample

          if path.includes?(neighbor)
            slice = path.slice_after(neighbor)
            path = slice.next.as(Array(Mazes::Cell))
          else
            path << neighbor
          end

          current = neighbor
        end

        # link path
        (1...path.size).each do |i|
          path[i].link(path[i - 1])
          unvisited.delete(path[i - 1])
        end
      end
    end
  end
end