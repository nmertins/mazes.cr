require "./grid"
require "./binary_tree"

grid = Mazes::Grid.new(4, 4)
Mazes::BinaryTree.on(grid)
puts grid