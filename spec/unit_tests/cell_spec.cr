require "../spec_helper"

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

  it "can be serialized to JSON" do
    cell = Mazes::Cell.new(0, 0)
    neighbor = Mazes::Cell.new(1, 0)
    cell.east = neighbor
    neighbor.west = cell
    cell.link(neighbor)

    cell_json = cell.to_json
    neighbor_json = neighbor.to_json

    cell_any = JSON.parse(cell_json)
    neighbor_any = JSON.parse(neighbor_json)

    cell_any["row"].as_i.should eq 0
    cell_any["column"].as_i.should eq 0
    cell_any["links"]["north"].should eq false
    cell_any["links"]["south"].should eq false
    cell_any["links"]["east"].should eq true
    cell_any["links"]["west"].should eq false

    neighbor_any["row"].as_i.should eq 1
    neighbor_any["column"].as_i.should eq 0
    neighbor_any["links"]["north"].should eq false
    neighbor_any["links"]["south"].should eq false
    neighbor_any["links"]["east"].should eq false
    neighbor_any["links"]["west"].should eq true
  end

  it "can be deserialized from JSON" do
    cell_json = %({"row": 0, "column": 0})
    cell = Mazes::Cell.from_json(cell_json)

    cell.row.should eq 0
    cell.column.should eq 0
  end
end
