require "./spec_helper"

describe "Maze::Grid" do
  it "should initialize a square grid of cells and assign cell neighbors" do
    grid = Mazes::Grid.new(5, 5)
    grid.size.should eq(25)

    ### Corners
    grid[0, 0].as(Mazes::Cell).neighbors.size.should eq(2)
    grid[4, 0].as(Mazes::Cell).neighbors.size.should eq(2)
    grid[0, 4].as(Mazes::Cell).neighbors.size.should eq(2)
    grid[4, 4].as(Mazes::Cell).neighbors.size.should eq(2)

    ### Edges
    (1..3).each do |i|
      grid[i, 0].as(Mazes::Cell).neighbors.size.should eq(3)
      grid[i, 4].as(Mazes::Cell).neighbors.size.should eq(3)
      grid[0, i].as(Mazes::Cell).neighbors.size.should eq(3)
      grid[4, i].as(Mazes::Cell).neighbors.size.should eq(3)
    end

    ### Interior
    (1..3).each do |x|
      (1..3).each do |y|
        grid[x, y].as(Mazes::Cell).neighbors.size.should eq(4)
      end
    end
  end

  it "returns nil for out-of-bounds indexes" do
    grid = Mazes::Grid.new(5, 5)

    expect_raises(NilAssertionError) do
      grid[0, 5].not_nil!
    end
  end
end