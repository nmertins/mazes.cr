require "../spec_helper"

describe "Mazes::Distances" do
  it "should be initalized with a root cell and the distance to its root is 0" do
    grid = Mazes::Grid.new(2, 2)
    root = grid[0, 0].as(Mazes::Cell)

    distances = Mazes::Distances.new(root)

    distances[root].should eq 0
  end

  it "can give the shortest path between two cells, given that the distances have already been calculated" do
    grid = Mazes::Grid.new(5, 5)

    # Sample maze to test shortest path. Starting point is the
    # northwest corner and the goal is the southwest corner.
    # *---*---*---*---*---*
    # | 0   1   2   3   4 |
    # *   *---*---*---*   *
    # |   |             5 |
    # *   *---*   *---*   *
    # |   |       | 7   6 |
    # *   *---*   *   *   *
    # |   |       | 8 |   |
    # *---*---*---*   *   *
    # | c   b   a   9 |   |
    # *---*---*---*---*---*

    # row 1
    cell = grid[0, 0].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[0, 1].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[0, 2].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[0, 3].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[0, 4].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south

    # row 2
    cell = grid[1, 0].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[1, 1].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[1, 2].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[1, 3].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[1, 4].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south

    # row 3
    cell = grid[2, 0].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[2, 1].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[2, 2].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[2, 3].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[2, 4].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south

    # row 4
    cell = grid[3, 0].as(Mazes::Cell)
    cell = grid[3, 1].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[3, 2].as(Mazes::Cell)
    cell = grid[3, 3].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south
    cell = grid[3, 4].as(Mazes::Cell)
    cell.link(cell.south.as(Mazes::Cell)) if cell.south

    # row 5
    cell = grid[4, 0].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[4, 1].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[4, 2].as(Mazes::Cell)
    cell.link(cell.east.as(Mazes::Cell)) if cell.east
    cell = grid[4, 3].as(Mazes::Cell)
    cell = grid[4, 4].as(Mazes::Cell)

    false.should be_true
  end
end
