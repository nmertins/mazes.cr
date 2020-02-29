require "./spec_helper"

describe "Utils::UnicodeBuilder" do
  it "should draw a box" do
    grid = Mazes::Grid.new(1, 1)
    output = Utils::UnicodeBuilder.to_unicode(grid)
    expected = String.build do |io|
      io << "\u{250c 2500 2500 2500 2510}\n"
      io << "\u2502   \u2502\n"
      io << "\u{2514 2500 2500 2500 2518}\n"
    end

    output.should eq expected
  end

  it "should draw 4 boxes" do
    grid = Mazes::Grid.new(2, 2)
    output = Utils::UnicodeBuilder.to_unicode(grid)
    expected = String.build do |io|
      io << "\u{250c 2500 2500 2500 252c 2500 2500 2500 2510}\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u{251c 2500 2500 2500 253c 2500 2500 2500 2524}\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u{2514 2500 2500 2500 2534 2500 2500 2500 2518}\n"
    end

    output.should eq expected
  end

  it "should draw a U shape" do
    grid = Mazes::Grid.new(2, 2)
    bottom_left = grid[0, 1].as(Mazes::Cell)
    bottom_left.link(bottom_left.north.as(Mazes::Cell)) if bottom_left.north
    bottom_left.link(bottom_left.east.as(Mazes::Cell)) if bottom_left.east

    bottom_left.neighbors.size.should eq 2

    bottom_right = grid[1, 1].as(Mazes::Cell)
    bottom_right.link(bottom_right.north.as(Mazes::Cell)) if bottom_right.north

    bottom_right.neighbors.size.should eq 2

    output = Utils::UnicodeBuilder.to_unicode(grid)
    expected = String.build do |io|
      io << "\u{250c 2500 2500 2500 252c 2500 2500 2500 2510}\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u2502       \u2502\n"
      io << "\u{2514 2500 2500 2500 2500 2500 2500 2500 2518}\n"
    end

    puts expected
    output.should eq expected
  end
end
