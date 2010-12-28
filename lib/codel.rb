module Piet
  class Codel
    attr_reader :color

    def initialize(color)
      @color = color
    end

    def distance(codel)
      self_pos = Color::POSITION[self]
      codel_pos = Color::POSITION[codel]
      lightness_change = (codel_pos[0] - self_pos[0]).modulo(3)
      hue_change = (codel_pos[1] - self_pos[1]).modulo(6)
      [hue_change, lightness_change]
    end

    def self.from_int(i)
      Color::MAP[i]
    end

    module Color
      def self.darken(color)
        color & MASK
      end

      def self.lighten(color)
        color | MASK
      end

      def self.int_value(hex)
        hex.to_i(16)
      end

      MASK = int_value("C0C0C0FF")
      POSITION = {}
      MAP = {}
      { :RED => "FF0000FF",
        :YELLOW => "FFFF00FF",
        :GREEN => "00FF00FF",
        :CYAN => "00FFFFFF",
        :BLUE => "0000FFFF",
        :MAGENTA => "FF00FFFF" }.each_with_index do |(name, value), index|
        color  = int_value(value)
        normal = self.const_set(name, Piet::Codel.new(color))
        light  = self.const_set("LIGHT_#{name}", Piet::Codel.new(lighten(color)))
        dark   = self.const_set("DARK_#{name}", Piet::Codel.new(darken(color)))
        POSITION[normal] = [1, index]
        POSITION[light]  = [0, index]
        POSITION[dark]   = [2, index]
        MAP[normal.color] = normal
        MAP[light.color] = light
        MAP[dark.color] = dark
      end
      BLACK = Piet::Codel.new(int_value("000000FF"))
      MAP[BLACK.color] = BLACK
      WHITE = Piet::Codel.new(int_value("FFFFFFFF"))
      MAP[WHITE.color] = WHITE
    end
  end
end