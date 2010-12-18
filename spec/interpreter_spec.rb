require 'spec_helper'

describe Piet::Interpreter do

  def build_image(w = 0, h = 0, options = {})
    ChunkyPNG::Image.new(w, h)
  end

  describe "when creating" do
    it "should raise error without an argument" do
      expect{ Piet::Interpreter.new }.to raise_error(ArgumentError)
    end

    it "should raise error without a png" do
      expect{ Piet::Interpreter.new(Object.new) }.to raise_error(TypeError)
    end

    it "should require a png" do
      expect{ Piet::Interpreter.new(build_image) }.to_not raise_error
    end
  end

end