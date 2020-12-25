require "../mazes"

grid = Mazes::Grid.new(10, 10)
Mazes::Wilsons.on(grid)
grid.to_png(filename:"wilsons.png")