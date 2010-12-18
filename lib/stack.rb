module Piet
  class Stack < ::Array
    DP_STATES = [:right, :down, :left, :up]
    CC_STATES = [:left, :right]

    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
      self.dp = DP_STATES.first
      self.cc = CC_STATES.first
    end

    attr_accessor :dp, :cc

    def add
      math(:+)
    end

    def subtract
      math(:-)
    end

    def multiply
      math(:*)
    end

    def divide
      math(:/)
    end

    def mod
      math(:modulo)
    end

    def not
      logic(self.pop.zero?)
    end

    def greater
      x, y = self.pop(2)
      logic(x > y)
    end

    def pointer
      n = self.pop
      self.dp = DP_STATES[(DP_STATES.index(self.dp) + n).modulo(DP_STATES.length)]
      self
    end

    def switch
      n = self.pop
      self.cc = CC_STATES[(CC_STATES.index(self.cc) + n).modulo(CC_STATES.length)]
      self
    end

    def sdup
      self.push(self.last)
    end

    def roll
      depth, n = self.pop(2)
      n.abs.times do
        (n > 0) ? self.insert(-1*(depth+1), self.pop) : self.push(self.delete_at(depth))
      end if depth > 0
      self
    end

    def out_char
      output(self.pop.chr)
      self
    end

    def out_num
      output(self.pop.to_s)
      self
    end

    def in_char
      x = input[0].ord
      self.push(x)
    end

    def in_num
      self.push(input.to_i)
    end

    private

    def math(operation)
      x, y = self.pop(2)
      self.push(x.send(operation, y))
    end

    def logic(operation)
      self.push(operation ? 1 : 0)
    end

    def output(s)
      @output.puts(s)
    end

    def input
      @input.gets
    end
  end
end