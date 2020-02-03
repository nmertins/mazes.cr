module Mazes
  class BinaryTree
    def self.on(grid : Mazes::Grid)
      grid.each_cell do |cell|
        neighbors = [] of Cell
        neighbors << cell.north.as(Cell) if cell.north
        neighbors << cell.east.as(Cell) if cell.east

        neighbor = neighbors.sample(1)

        cell.link(neighbor) if neighbor
      end

      grid
    end
  end
end