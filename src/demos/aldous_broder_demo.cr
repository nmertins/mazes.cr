require "../mazes"

grid = Mazes::Grid.new(20, 20)
Mazes::AldousBroder.on(grid)
grid.to_png(filename: "aldous_broder.png")