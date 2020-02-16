require "./cell"
require "stumpy_png"

include StumpyPNG

module Mazes
  class Grid
    property rows
    property columns
    @grid : Array(Array(Cell))

    def initialize(rows : Int32, columns : Int32)
      @rows = rows
      @columns = columns
      @grid = prepare_grid
      configure_cells
    end

    def prepare_grid
      Array.new(rows) do |row|
        Array.new(columns) do |column|
          Cell.new(row, column)
        end
      end
    end

    def configure_cells
      each_cell do |cell|
        row, column = cell.row, cell.column
        cell.north = self[row - 1, column]
        cell.south = self[row + 1, column]
        cell.east = self[row, column + 1]
        cell.west = self[row, column - 1]
      end
    end

    def [](row, column)
      return nil unless 0 <= row < @rows
      return nil unless 0 <= column < @columns
      @grid[row][column]
    end

    def each_row
      @grid.each do |row|
        yield row
      end
    end

    def each_cell
      each_row do |row|
        row.each do |cell|
          yield cell if cell
        end
      end
    end

    def random_cell
      row = rand(@rows)
      column = rand(@columns)
      self[row, column]
    end

    def size
      @rows * @columns
    end

    def to_s(io)
      io << "+" + "---+" * @columns + "\n"

      each_row do |row|
        top = "|"
        bottom = "+"

        row.each do |cell|
          body = "   "
          east_boundary = (cell.linked?(cell.east) ? " " : "|")
          top += body + east_boundary

          south_boundary = (cell.linked?(cell.south) ? "   " : "---")
          corner = "+"
          bottom += south_boundary + corner
        end

        io << top + "\n"
        io << bottom + "\n"
      end
    end

    def to_png(cell_size = 10)
      img_width = cell_size * @columns
      img_height = cell_size * @rows

      background = RGBA.from_hex("#ffffff")
      wall = RGBA.from_hex("#000000")
      
      img = Canvas.new(img_width + 1, img_height + 1, background)

      (0..img_width).each do |x|
        img[x, 0] = wall
      end

      (0..img_height).each do |y|
        img[0, y] = wall
      end

      each_cell do |cell|
        x1 = cell.column * cell_size
        y1 = cell.row * cell_size
        x2 = x1 + cell_size
        y2 = y1 + cell_size

        unless cell.linked?(cell.east)
          (y1..y2).each do |y|
            img[x2, y] = wall
          end
        end

        unless cell.linked?(cell.south)
          (x1..x2).each do |x|
            img[x, y2] = wall
          end
        end
      end

      StumpyPNG.write(img, "maze.png")
    end
  end
end