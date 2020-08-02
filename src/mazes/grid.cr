require "./cell"
require "../utils/unicode_builder"
require "json"
require "stumpy_png"

include StumpyPNG

module Mazes
  class Grid
    property rows
    property columns
    @grid : Array(Array(Cell))

    def initialize(@rows : Int32, @columns : Int32)
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
        cell.north = self[row - 1, column]?
        cell.south = self[row + 1, column]?
        cell.east = self[row, column + 1]?
        cell.west = self[row, column - 1]?
      end
    end

    def [](row, column)
      @grid[row][column]
    end

    def []?(row, column)
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

    def contents_of(cell : Cell)
      " "
    end

    def to_s(io : IO)
      io << Utils::UnicodeBuilder.to_unicode(self)
    end

    def background_color_for(cell)
      RGBA.from_hex("#ffffff")
    end

    def to_png(cell_size = 10, filename = "maze.png")
      img_width = cell_size * @columns
      img_height = cell_size * @rows

      img = Canvas.new(img_width + 1, img_height + 1)

      wall = RGBA.from_hex("#000000")

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

        (x1 + 1..x2).each do |x|
          (y1 + 1..y2).each do |y|
            img[x, y] = background_color_for(cell)
          end
        end

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

      StumpyPNG.write(img, filename)
    end

    def to_json
      String.build do |str|
        to_json(str)
      end
    end

    def to_json(io : IO)
      JSON.build(io) do |json|
        json.object do
          json.field "rows", @rows
          json.field "columns", @columns
          json.field "cells" do
            json.array do
              each_cell do |cell|
                cell.to_json(io)
                io << ',' unless is_last(cell)
              end
            end
          end
        end
      end
    end

    private def is_last(cell)
      cell.row == @rows-1 && cell.column == @columns-1
    end
  end
end
