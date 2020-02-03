require "../mazes.cr"

grid = Mazes::Grid.new(10, 10)
Mazes::BinaryTree.on(grid)
puts grid