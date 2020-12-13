require "../mazes"

6.times do |n|
  grid = Mazes::ColoredGrid.new(20, 20)
  Mazes::AldousBroder.on(grid)

  middle = grid[(grid.rows / 2).to_i, (grid.columns / 2).to_i]
  grid.distances = middle.distances
  filename = "aldous_broder_%02d.png" % n
  grid.to_png(filename: filename)
end