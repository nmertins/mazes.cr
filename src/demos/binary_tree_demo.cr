require "../mazes.cr"

grid = Mazes::Grid.new(4, 4)
Mazes::BinaryTree.on(grid)
puts grid