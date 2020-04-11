require "../mazes.cr"

grid = Mazes::DistanceGrid.new(5, 5)
Mazes::BinaryTree.on(grid)

start = grid[0, 0].as(Mazes::Cell)
distances = start.distances

grid.distances = distances
puts grid
