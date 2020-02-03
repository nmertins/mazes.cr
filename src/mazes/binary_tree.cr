module Mazes
  class BinaryTree
    def self.on(grid : Mazes::Grid)
      grid.each_cell do |cell|
        neighbors = [] of Cell
        neighbors << cell.north.as(Cell) if cell.north
        neighbors << cell.east.as(Cell) if cell.east

        unless neighbors.size == 0
          neighbor = neighbors.sample
          cell.link(neighbor)
        end
      end

      grid
    end
  end
end