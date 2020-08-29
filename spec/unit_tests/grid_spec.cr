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
      grid[0, 5]?.not_nil!
    end
  end

  it "can be serialized to JSON" do
    grid = create_2x2_U_grid
    grid_json = grid.to_json
    grid_any = JSON.parse(grid_json)
    grid_any["rows"].should eq 2
    grid_any["columns"].should eq 2
    grid_any["cells"].size.should eq 4

    grid_any["cells"][0]["row"].should eq 0
    grid_any["cells"][0]["column"].should eq 0
    grid_any["cells"][0]["links"]["north"].should be_false
    grid_any["cells"][0]["links"]["south"].should be_true
    grid_any["cells"][0]["links"]["east"].should be_false
    grid_any["cells"][0]["links"]["west"].should be_false

    grid_any["cells"][1]["row"].should eq 0
    grid_any["cells"][1]["column"].should eq 1
    grid_any["cells"][1]["links"]["north"].should be_false
    grid_any["cells"][1]["links"]["south"].should be_true
    grid_any["cells"][1]["links"]["east"].should be_false
    grid_any["cells"][1]["links"]["west"].should be_false

    grid_any["cells"][2]["row"].should eq 1
    grid_any["cells"][2]["column"].should eq 0
    grid_any["cells"][2]["links"]["north"].should be_true
    grid_any["cells"][2]["links"]["south"].should be_false
    grid_any["cells"][2]["links"]["east"].should be_true
    grid_any["cells"][2]["links"]["west"].should be_false

    grid_any["cells"][3]["row"].should eq 1
    grid_any["cells"][3]["column"].should eq 1
    grid_any["cells"][3]["links"]["north"].should be_true
    grid_any["cells"][3]["links"]["south"].should be_false
    grid_any["cells"][3]["links"]["east"].should be_false
    grid_any["cells"][3]["links"]["west"].should be_true
  end

  it "can be deserialized from JSON" do
    grid_json = create_2x2_U_grid_json
    grid = Mazes::Grid.from_json(grid_json)

    grid.size.should eq 4
    grid[0, 0].as(Mazes::Cell).links.size.should eq 1
    grid[0, 1].as(Mazes::Cell).links.size.should eq 1
    grid[1, 0].as(Mazes::Cell).links.size.should eq 2
    grid[1, 1].as(Mazes::Cell).links.size.should eq 2
  end
end
