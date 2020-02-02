require "./spec_helper"

describe "Maze::Grid" do
  it "should initialize a square grid of cells and assign cell neighbors" do
    grid = Mazes::Grid.new(5, 5)
    grid.size.should eq(25)

    grid[0, 0].as(Mazes::Cell).neighbors.size.should eq(2)  # corner
    grid[1, 0].as(Mazes::Cell).neighbors.size.should eq(3)  # edge
    grid[1, 1].as(Mazes::Cell).neighbors.size.should eq(4)  # interior
  end
end