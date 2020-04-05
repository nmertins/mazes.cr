require "../spec_helper"

describe "Mazes::Distances" do
  it "should be initalized with a root cell and the distance to its root is 0" do
    grid = Mazes::Grid.new(2, 2)
    root = grid[0, 0].as(Mazes::Cell)

    distances = Mazes::Distances.new(root)

    distances[root].should eq 0
  end

end
