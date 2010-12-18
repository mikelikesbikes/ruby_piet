image = ChunkyPNG::Image.from_file('programs/Piet_hello.png')
(0...image.height).inject([]) { |pixel_arr, row_index| pixel_arr << image.row(row_index) }