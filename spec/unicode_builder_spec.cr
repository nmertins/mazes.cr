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

    output.should eq(expected)
  end

  it "should draw 4 boxes" do
    grid = Mazes::Grid.new(2, 2)
    output = Utils::UnicodeBuilder.to_unicode(grid)
    expected = String.build do |io|
      io << "\u{250c 2500 2500 2500 2500 2500 2500 2500 2510}\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u{251c 2500 2500 2500 253c 2500 2500 2500 2524}\n"
      io << "\u2502   \u2502   \u2502\n"
      io << "\u{2514 2500 2500 2500 2500 2500 2500 2500 2518}\n"
    end

    output.should eq(expected)
  end
end
