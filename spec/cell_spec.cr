require "./spec_helper"

describe "Mazes::Cell" do
  it "ought to know where it lives within the grid" do
    row = 0
    column = 0
    cell = Mazes::Cell.new(row, column)

    cell.row.should eq(0)
    cell.column.should eq(0)
  end

  it "can keep track of which neighboring cells are linked to this cell" do
    cell = Mazes::Cell.new(0, 0)
    neighbor = Mazes::Cell.new(1, 0)

    cell.links.size.should eq(0)
    neighbor.links.size.should eq(0)
    cell.linked?(neighbor).should be_false
    
    cell.link(neighbor)
    cell.links.size.should eq(1)
    neighbor.links.size.should eq(1)
    cell.linked?(neighbor).should be_true

    cell.unlink(neighbor)
    cell.links.size.should eq(0)
    neighbor.links.size.should eq(0)
    cell.linked?(neighbor).should be_false
  end

  it "can give a list of neighbors" do
    cell = Mazes::Cell.new(0, 0)
    cell.neighbors.size.should eq(0)
  end
end