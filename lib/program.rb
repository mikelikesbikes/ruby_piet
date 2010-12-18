require 'chunky_png'

module Piet
  class Program
    def initialize(png)
      raise TypeError unless png.is_a? ChunkyPNG::Image
    end
  end
end