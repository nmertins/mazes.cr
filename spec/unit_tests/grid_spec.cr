require "../spec_helper"

describe "Maze::Grid" do
  it "creates 4 unlinked cells" do
    grid = Mazes::Grid.new(2, 2)

    top_left = grid[0, 0].as(Mazes::Cell)
    top_left.linked?(top_left.east).should be_false
    top_left.linked?(top_left.south).should be_false

    top_right = grid[1, 0].as(Mazes::Cell)
    top_right.linked?(top_right.west).should be_false
    top_right.linked?(top_right.south).should be_false

    bottom_left = grid[0, 1].as(Mazes::Cell)
    bottom_left.linked?(bottom_left.north).should be_false
    bottom_left.linked?(bottom_left.east).should be_false

    bottom_right = grid[1, 1].as(Mazes::Cell)
    bottom_right.linked?(bottom_right.north).should be_false
    bottom_right.linked?(bottom_right.west).should be_false
  end

  it "should initialize a square grid of cells and assign cell neighbors" do
    grid = Mazes::Grid.new(5, 5)
    grid.size.should eq(25)

    ### Corners
    grid[0, 0].as(Mazes::Cell).neighbors.size.should eq 2
    grid[4, 0].as(Mazes::Cell).neighbors.size.should eq 2
    grid[0, 4].as(Mazes::Cell).neighbors.size.should eq 2
    grid[4, 4].as(Mazes::Cell).neighbors.size.should eq 2

    ### Edges
    (1..3).each do |i|
      grid[i, 0].as(Mazes::Cell).neighbors.size.should eq 3
      grid[i, 4].as(Mazes::Cell).neighbors.size.should eq 3
      grid[0, i].as(Mazes::Cell).neighbors.size.should eq 3
      grid[4, i].as(Mazes::Cell).neighbors.size.should eq 3
    end

    ### Interior
    (1..3).each do |x|
      (1..3).each do |y|
        grid[x, y].as(Mazes::Cell).neighbors.size.should eq 4
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
