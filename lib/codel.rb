module Piet
  class Codel
    attr_reader :color

    def initialize(color)
      @color = color
    end

    def distance(codel)
      self_pos = COLOR_POSITION[self]
      codel_pos = COLOR_POSITION[codel]
      lightness_change = (codel_pos[0] - self_pos[0]).modulo(3)
      hue_change = (codel_pos[1] - self_pos[1]).modulo(6)
      [hue_change, lightness_change]
    end

    def self.darken(color)
      color & COLOR_MASK
    end

    def self.lighten(color)
      color | COLOR_MASK
    end

    def self.int_value(hex)
      hex.to_i(16)
    end

    COLOR_MASK = int_value("C0C0C0FF")

    COLOR_POSITION = {}
    COLOR_MAP = {}
    { :RED => "FF0000FF",
      :YELLOW => "FFFF00FF",
      :GREEN => "00FF00FF",
      :CYAN => "00FFFFFF",
      :BLUE => "0000FFFF",
      :MAGENTA => "FF00FFFF" }.each_with_index do |(name, value), index|
      color  = int_value(value)
      normal = self.const_set(name, self.new(color))
      light  = self.const_set("LIGHT_#{name}", self.new(lighten(color)))
      dark   = self.const_set("DARK_#{name}", self.new(darken(color)))
      COLOR_POSITION[normal] = [1, index]
      COLOR_POSITION[light]  = [0, index]
      COLOR_POSITION[dark]   = [2, index]
      COLOR_MAP[normal.color] = normal
      COLOR_MAP[light.color] = light
      COLOR_MAP[dark.color] = dark
    end
    BLACK = self.new(int_value("000000FF"))
    COLOR_MAP[BLACK.color] = BLACK
    WHITE = self.new(int_value("FFFFFFFF"))
    COLOR_MAP[WHITE.color] = WHITE
  end
end