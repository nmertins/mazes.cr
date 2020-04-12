require "../mazes.cr"

grid = Mazes::DistanceGrid.new(5, 5)
Mazes::BinaryTree.on(grid)
puts grid

start = grid[0, 0].as(Mazes::Cell)
distances = start.distances

# Print results of Dijkstra's Algorithm
# grid.distances = distances
# puts grid

puts "path from northeast corner to southwest corner:"
goal = grid[grid.rows - 1, 0].as(Mazes::Cell)
grid.distances = distances.path_to(goal)
puts grid
