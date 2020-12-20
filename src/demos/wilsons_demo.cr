require "../mazes"

grid = Mazes::Grid.new(2, 2)
Mazes::Wilsons.on(grid)
grid.to_png(filename:"wilsons.png")