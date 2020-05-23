require "../mazes.cr"

grid = Mazes::DistanceGrid.new(5, 5)
Mazes::BinaryTree.on(grid)

start = grid[0, 0]

distances = start.as(Mazes::Cell).distances
new_start, distance = distances.max

new_distances = new_start.as(Mazes::Cell).distances
goal, distance = new_distances.max

grid.distances = new_distances.path_to(goal)
puts grid
