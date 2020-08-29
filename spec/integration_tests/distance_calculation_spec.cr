require "../spec_helper"

describe "Distance between cells" do
  it "is given as a map with values relative to a root cell" do
    grid = create_2x2_U_grid
    root = grid[0, 0].as(Mazes::Cell)

    # Our grid should now look like:
    #
    # *---*---*
    # | R |   |
    # *   *   *
    # |       |
    # *---*---*
    #
    # Where R is the root cell.
    # Therefore, the distnaces should be:
    #
    # *---*---*
    # | 0 | 3 |
    # *   *   *
    # | 1   2 |
    # *---*---*

    distances = root.distances

    distances[root].should eq 0
    distances[grid[1, 0].as(Mazes::Cell)].should eq 1
    distances[grid[1, 1].as(Mazes::Cell)].should eq 2
    distances[grid[0, 1].as(Mazes::Cell)].should eq 3
  end
end
