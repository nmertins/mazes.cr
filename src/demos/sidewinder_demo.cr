require "../mazes.cr"

grid = Mazes::Grid.new(10, 10)
Mazes::Sidewinder.on(grid)
puts grid