require 'chunky_png'

@image = ChunkyPNG::Image.from_file('programs/Piet_hello.png')
@arr = (0...@image.height).collect { |i| @image.row(i) }

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

@color_blocks = Piet::ColorBlockHash.from_array(@arr)

def walk_row(arr)
  y = 0
  x = 0
  c = arr[y][x]
  while arr[y][x]
    puts "#%08x" % arr[y][x]
    puts "[#{x},#{y}]"
    while arr[y][x] && c == arr[y][x]
      c = arr[y][x]
      x += 1
    end
    c = arr[y][x]
  end
  puts "#%08x" % arr[y][x]
  puts "[#{x},#{y}]"
end
