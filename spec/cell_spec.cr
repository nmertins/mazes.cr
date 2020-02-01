require "./spec_helper"

describe "Mazes::Cell" do
  it "ought to know where it lives within the grid" do
    row = 0
    column = 0
    cell = Mazes::Cell.new(row, column)

    cell.row.should eq(0)
    cell.column.should eq(0)
  end
end