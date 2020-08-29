require "spec"
require "../src/mazes.cr"

def create_2x2_U_grid : Mazes::Grid
  # Creates simple U-shaped grid:
  #
  # *---*---*
  # |   |   |
  # *   *   *
  # |       |
  # *---*---*

  grid = Mazes::Grid.new(2,2)
  top_left = grid[0, 0].as(Mazes::Cell)
  top_left.link(top_left.south.as(Mazes::Cell)) if top_left.south

  bottom_right = grid[1, 1].as(Mazes::Cell)
  bottom_right.link(bottom_right.west.as(Mazes::Cell)) if bottom_right.west
  bottom_right.link(bottom_right.north.as(Mazes::Cell)) if bottom_right.north

  grid
end

def create_2x2_U_grid_json : String
  grid_json = %({
    "rows": 2,
    "columns": 2,
    "cells": [
      {
        "row": 0,
        "column": 0,
        "links": {
          "north": false,
          "sourth": false,
          "east": false,
          "west": false
        }
      },
      {
        "row": 0,
        "column": 1,
        "links": {
          "north": false,
          "sourth": false,
          "east": false,
          "west": false
        }
      },
      {
        "row": 1,
        "column": 0,
        "links": {
          "north": false,
          "sourth": false,
          "east": false,
          "west": false
        }
      },
      {
        "row": 1,
        "column": 1,
        "links": {
          "north": false,
          "sourth": false,
          "east": false,
          "west": false
        }
      }
    ]
  })
end
