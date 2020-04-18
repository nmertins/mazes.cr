require "../spec_helper"

describe "Mazes::Distances" do
  it "should be initalized with a root cell and the distance to its root is 0" do
    grid = Mazes::Grid.new(2, 2)
    root = grid[0, 0].as(Mazes::Cell)

    distances = Mazes::Distances.new(root)

    distances[root].should eq 0
  end

  it "can give the shortest path between two cells, given that the distances have already been calculated" do
    grid = Mazes::Grid(5, 5)

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

    false.should be_true
  end
end
