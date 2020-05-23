require "../mazes.cr"

grid = Mazes::ColoredGrid.new(25, 25)
Mazes::BinaryTree.on(grid)

start = grid[(grid.rows / 2).to_i, (grid.columns / 2).to_i]
grid.distances = start.as(Mazes::Cell).distances

grid.to_png(filename: "colorized.png")
